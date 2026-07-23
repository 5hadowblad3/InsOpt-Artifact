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

# Build the AFL-only instrumented version
(
    export OUT="$OUT/afl"
    export LDFLAGS="$LDFLAGS -L$OUT"

    "$MAGMA/build.sh"
    "$TARGET/build.sh"
)