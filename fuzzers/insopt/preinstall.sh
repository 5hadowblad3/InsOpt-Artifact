#!/bin/bash
set -e

apt-get update && \
    apt-get install -y make build-essential git wget libexpat1-dev

apt-get install -y apt-utils apt-transport-https ca-certificates gnupg

echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-18 main >> /etc/apt/sources.list
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

apt-get update && \
    apt-get install -y clang-18 clangd-18 clang-tools-18 libc++1-18 libc++-18-dev \
      libc++abi1-18 libc++abi-18-dev libclang1-18 libclang-18-dev libclang-common-18-dev \
      libclang-cpp18 libclang-cpp18-dev liblld-18 liblld-18-dev liblldb-18 \
      liblldb-18-dev libllvm18 libomp-18-dev libomp5-18 lld-18 lldb-18 \
      llvm-18 llvm-18-dev llvm-18-runtime llvm-18-tools

update-alternatives \
  --install /usr/lib/llvm              llvm             /usr/lib/llvm-18  200 \
  --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-18  \
    --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-18 \
    --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-18 \
    --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-18 \
    --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-18 \
    --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-18 \
    --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-18 \
    --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-18 \
    --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-18 \
    --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-18 \
    --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-18 \
    --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-18 \
    --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-18 \
    --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-18 \
    --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-18 \
    --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-18 \
    --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-18 \
    --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-18 \
    --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-18 \
    --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-18 \
    --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-18

update-alternatives \
  --install /usr/bin/clang                 clang                  /usr/bin/clang-18     200 \
  --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-18 \
  --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-18
