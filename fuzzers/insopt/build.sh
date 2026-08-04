#!/bin/bash
set -e

##
# Pre-requirements:
# - env FUZZER: path to fuzzer work dir
##

cd "$FUZZER/repo"
export CC=clang
export CXX=clang++
export LLVM_CONFIG=llvm-config-13
export AFL_NO_X86=1
export PYTHON_INCLUDE=/
make -j$(nproc) || exit 1
make -C utils/aflpp_driver || exit 1

mkdir -p "$OUT/afl" "$OUT/cmplog"
