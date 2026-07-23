#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
# - env TARGET: path to target work dir
# - env MAGMA: path to Magma support files
# - env OUT: path to directory where artifacts are stored
# - env CFLAGS and CXXFLAGS must be set to link against Magma instrumentation
##

export CC="$FUZZER/repo/afl-clang-lto"
export CXX="$FUZZER/repo/afl-clang-lto++"
LLVM_PATH=/usr/lib/llvm-18/bin
export AS="${LLVM_PATH}/llvm-as"
export RANLIB="${LLVM_PATH}/llvm-ranlib"
export AR="${LLVM_PATH}/llvm-ar"
export LD="${LLVM_PATH}/ld.lld"
export NM="${LLVM_PATH}/llvm-nm"

export LIBS="$LIBS -lstdc++ $FUZZER/repo/utils/aflpp_driver/libAFLDriver.a"

# Some targets do not support a static AFL memory region
DYNAMIC_TARGETS=(php openssl)
TARGET_NAME="$(basename $TARGET)"
if [[ " ${DYNAMIC_TARGETS[@]} " =~ " $TARGET_NAME " ]]; then
    export AFL_LLVM_MAP_DYNAMIC=1
fi

# 确定当前容器对应的程序
# 从容器名称中获取程序名
CONTAINER_INFO=$(cat /proc/self/cgroup | grep -o '[^/]*/[^/]*/[^/]*' | tail -1)
echo "Container info: $CONTAINER_INFO"

if [[ "$CONTAINER_INFO" =~ ([^/]*)/([^/]*)/([^/]*) ]]; then
    FUZZER_NAME="${BASH_REMATCH[1]}"
    TARGET_NAME="${BASH_REMATCH[2]}"
    PROGRAM_NAME="${BASH_REMATCH[3]}"
    echo "Detected: Fuzzer=$FUZZER_NAME, Target=$TARGET_NAME, Program=$PROGRAM_NAME"
else
    # 无法从容器名称获取，尝试从环境变量获取
    PROGRAM_NAME=$(basename "$0" | cut -d '_' -f1)
    echo "Using fallback program name: $PROGRAM_NAME"
fi

# 创建统计目录
STATS_DIR="$OUT/instrumentation_stats"
mkdir -p "$STATS_DIR"

# 设置程序特定的环境变量
export AFL_PRINT_TIME="1"  # 重置计数器
export CURRENT_TARGET="$TARGET_NAME"
export CURRENT_PROGRAM="$PROGRAM_NAME"
export AFL_LLVM_INSTRUMENT_FILE="$PROGRAM_NAME"  # 告诉编译器当前正在构建哪个程序

echo "=== Building $TARGET_NAME/$PROGRAM_NAME with instrumentation statistics ==="
echo "Statistics will be saved to: $AFL_STATS_FILENAME"

# 创建输出目录
export OUT="$OUT/afl"
export LDFLAGS="$LDFLAGS -L$OUT"

# 构建
"$MAGMA/build.sh"

# 根据不同的target执行特定的构建操作
case "$TARGET_NAME" in
    "libxml2")
        cd "$TARGET/repo"
        ./autogen.sh \
            --with-http=no \
            --with-python=no \
            --with-lzma=yes \
            --with-threads=no \
            --disable-shared
        make -j$(nproc) clean
        make -j$(nproc) all

        cp xmllint "$OUT/"

        # 如果当前程序是特定的fuzzer，只构建它而不是所有fuzzer
        if [[ "$PROGRAM_NAME" == "libxml2_xml_read_memory_fuzzer" || "$PROGRAM_NAME" == "xmllint" ]]; then
            echo "Building $PROGRAM_NAME specifically..."
            if [[ "$PROGRAM_NAME" == "libxml2_xml_read_memory_fuzzer" ]]; then
                $CXX $CXXFLAGS -std=c++11 -Iinclude/ -I"$TARGET/src/" \
                    "$TARGET/src/$PROGRAM_NAME.cc" -o "$OUT/$PROGRAM_NAME" \
                    .libs/libxml2.a $LDFLAGS $LIBS -lz -llzma
            fi
        else
            # 构建所有fuzzer
            for fuzzer in libxml2_xml_read_memory_fuzzer libxml2_xml_reader_for_file_fuzzer; do
                $CXX $CXXFLAGS -std=c++11 -Iinclude/ -I"$TARGET/src/" \
                    "$TARGET/src/$fuzzer.cc" -o "$OUT/$fuzzer" \
                    .libs/libxml2.a $LDFLAGS $LIBS -lz -llzma
            done
        fi
        ;;
        
    "openssl")
        cd "$TARGET/repo"

        CONFIGURE_FLAGS=""
        if [[ $CFLAGS = *sanitize=memory* ]]; then
            CONFIGURE_FLAGS="no-asm"
        fi

        # the config script supports env var LDLIBS instead of LIBS
        export LDLIBS="$LIBS"

        ./config --debug enable-fuzz-libfuzzer enable-fuzz-afl disable-tests -DPEDANTIC \
            -DFUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION no-shared no-module \
            enable-tls1_3 enable-rc5 enable-md2 enable-ec_nistp_64_gcc_128 enable-ssl3 \
            enable-ssl3-method enable-nextprotoneg enable-weak-ssl-ciphers \
            $CFLAGS -fno-sanitize=alignment $CONFIGURE_FLAGS

        make -j$(nproc) clean
        make -j$(nproc) LDCMD="$CXX $CXXFLAGS"

        if [[ "$PROGRAM_NAME" =~ ^(asn1|asn1parse|bignum|server|client|x509)$ ]]; then
            echo "Building $PROGRAM_NAME specifically..."
            cp "fuzz/$PROGRAM_NAME" "$OUT/" 2>/dev/null || echo "Warning: $PROGRAM_NAME not found in fuzz directory"
        else
            # 复制所有fuzzers
            fuzzers=$(find fuzz -executable -type f '!' -name \*.py '!' -name \*-test '!' -name \*.pl)
            for f in $fuzzers; do
                fuzzer=$(basename $f)
                cp $f "$OUT/"
            done
        fi
        ;;
        
    "php")
        cd "$TARGET/repo"
        export ONIG_CFLAGS="-I$PWD/oniguruma/src"
        export ONIG_LIBS="-L$PWD/oniguruma/src/.libs -l:libonig.a"

        # PHP's zend_function union is incompatible with the object-size sanitizer
        export EXTRA_CFLAGS="$CFLAGS -fno-sanitize=object-size"
        export EXTRA_CXXFLAGS="$CXXFLAGS -fno-sanitize=object-size"

        unset CFLAGS
        unset CXXFLAGS

        #build the php library
        ./buildconf
        LIB_FUZZING_ENGINE="-Wall" ./configure \
            --disable-all \
            --enable-option-checking=fatal \
            --enable-fuzzer \
            --enable-exif \
            --enable-phar \
            --enable-intl \
            --enable-mbstring \
            --without-pcre-jit \
            --disable-phpdbg \
            --disable-cgi \
            --with-pic

        make -j$(nproc) clean

        # build oniguruma and link statically
        pushd oniguruma
        autoreconf -vfi
        ./configure --disable-shared
        make -j$(nproc)
        popd

        make -j$(nproc)

        # Generate seed corpora
        sapi/cli/php sapi/fuzzer/generate_unserialize_dict.php
        sapi/cli/php sapi/fuzzer/generate_parser_corpus.php

        if [[ "$PROGRAM_NAME" =~ ^(json|exif|unserialize|parser)$ ]]; then
            echo "Building $PROGRAM_NAME specifically..."
            cp "sapi/fuzzer/php-fuzz-$PROGRAM_NAME" "$OUT/$PROGRAM_NAME"
        else
            # 复制所有fuzzers
            FUZZERS="php-fuzz-json php-fuzz-exif php-fuzz-mbstring php-fuzz-unserialize php-fuzz-parser"
            for fuzzerName in $FUZZERS; do
                cp sapi/fuzzer/$fuzzerName "$OUT/${fuzzerName/php-fuzz-/}"
            done
        fi

        for fuzzerName in `ls sapi/fuzzer/corpus`; do
            mkdir -p "$TARGET/corpus/${fuzzerName}"
            cp sapi/fuzzer/corpus/${fuzzerName}/* "$TARGET/corpus/${fuzzerName}/"
        done
        ;;
        
    "poppler")
        export WORK="$TARGET/work"
        rm -rf "$WORK"
        mkdir -p "$WORK"
        mkdir -p "$WORK/lib" "$WORK/include"

        pushd "$TARGET/freetype2"
        ./autogen.sh
        ./configure --prefix="$WORK" --disable-shared PKG_CONFIG_PATH="$WORK/lib/pkgconfig"
        make -j$(nproc) clean
        make -j$(nproc)
        make install

        mkdir -p "$WORK/poppler"
        cd "$WORK/poppler"
        rm -rf *

        EXTRA=""
        test -n "$AR" && EXTRA="$EXTRA -DCMAKE_AR=$AR"
        test -n "$RANLIB" && EXTRA="$EXTRA -DCMAKE_RANLIB=$RANLIB"

        cmake "$TARGET/repo" \
          $EXTRA \
          -DCMAKE_BUILD_TYPE=debug \
          -DBUILD_SHARED_LIBS=OFF \
          -DFONT_CONFIGURATION=generic \
          -DBUILD_GTK_TESTS=OFF \
          -DBUILD_QT5_TESTS=OFF \
          -DBUILD_CPP_TESTS=OFF \
          -DENABLE_LIBPNG=ON \
          -DENABLE_LIBTIFF=ON \
          -DENABLE_LIBJPEG=ON \
          -DENABLE_SPLASH=ON \
          -DENABLE_UTILS=ON \
          -DWITH_Cairo=ON \
          -DENABLE_CMS=none \
          -DENABLE_LIBCURL=OFF \
          -DENABLE_GLIB=OFF \
          -DENABLE_GOBJECT_INTROSPECTION=OFF \
          -DENABLE_QT5=OFF \
          -DENABLE_LIBCURL=OFF \
          -DWITH_NSS3=OFF \
          -DFREETYPE_INCLUDE_DIRS="$WORK/include/freetype2" \
          -DFREETYPE_LIBRARY="$WORK/lib/libfreetype.a" \
          -DICONV_LIBRARIES="/usr/lib/x86_64-linux-gnu/libc.so" \
          -DCMAKE_EXE_LINKER_FLAGS_INIT="$LIBS"
        
        make -j$(nproc) poppler poppler-cpp pdfimages pdftoppm
        
        if [[ "$PROGRAM_NAME" == "pdf_fuzzer" ]]; then
            cp "$WORK/poppler/utils/"{pdfimages,pdftoppm} "$OUT/"
            $CXX $CXXFLAGS -std=c++11 -I"$WORK/poppler/cpp" -I"$TARGET/repo/cpp" \
                "$TARGET/src/pdf_fuzzer.cc" -o "$OUT/pdf_fuzzer" \
                "$WORK/poppler/cpp/libpoppler-cpp.a" "$WORK/poppler/libpoppler.a" \
                "$WORK/lib/libfreetype.a" $LDFLAGS $LIBS -ljpeg -lz \
                -lopenjp2 -lpng -ltiff -llcms2 -lm -lpthread -pthread
        elif [[ "$PROGRAM_NAME" == "pdfimages" ]]; then
            cp "$WORK/poppler/utils/pdfimages" "$OUT/"
        elif [[ "$PROGRAM_NAME" == "pdftoppm" ]]; then
            cp "$WORK/poppler/utils/pdftoppm" "$OUT/"
        else
            # 复制所有程序
            cp "$WORK/poppler/utils/"{pdfimages,pdftoppm} "$OUT/"
            $CXX $CXXFLAGS -std=c++11 -I"$WORK/poppler/cpp" -I"$TARGET/repo/cpp" \
                "$TARGET/src/pdf_fuzzer.cc" -o "$OUT/pdf_fuzzer" \
                "$WORK/poppler/cpp/libpoppler-cpp.a" "$WORK/poppler/libpoppler.a" \
                "$WORK/lib/libfreetype.a" $LDFLAGS $LIBS -ljpeg -lz \
                -lopenjp2 -lpng -ltiff -llcms2 -lm -lpthread -pthread
        fi
        ;;
        
    *)
        echo "Unknown target: $TARGET_NAME, using default build script"
        "$TARGET/build.sh"
        ;;
esac

# 统计信息已通过环境变量保存到 $AFL_STATS_FILENAME
echo "Build completed for $TARGET_NAME/$PROGRAM_NAME"
echo "Check instrumentation statistics at: $AFL_STATS_FILENAME"

# 汇总统计信息
if [ -f "$AFL_STATS_FILENAME" ]; then
    echo "===== Instrumentation Statistics Summary =====" >> "$STATS_DIR/summary.txt"
    echo "Target: $TARGET_NAME, Program: $PROGRAM_NAME" >> "$STATS_DIR/summary.txt"
    cat "$AFL_STATS_FILENAME" >> "$STATS_DIR/summary.txt"
    echo "=============================================" >> "$STATS_DIR/summary.txt"
    echo "" >> "$STATS_DIR/summary.txt"
fi