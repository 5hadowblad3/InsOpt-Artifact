# #!/bin/bash
# set -e

# apt-get update && \
#     apt-get install -y make build-essential git wget libexpat1-dev

# apt-get install -y apt-utils apt-transport-https ca-certificates gnupg

# echo deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-18 main >> /etc/apt/sources.list
# wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -

# apt-get update && \
#     apt-get install -y clang-18 clangd-18 clang-tools-18 libc++1-18 libc++-18-dev \
#       libc++abi1-18 libc++abi-18-dev libclang1-18 libclang-18-dev libclang-common-18-dev \
#       libclang-cpp18 libclang-cpp18-dev liblld-18 liblld-18-dev liblldb-18 \
#       liblldb-18-dev libllvm18 libomp-18-dev libomp5-18 lld-18 lldb-18 \
#       llvm-18 llvm-18-dev llvm-18-runtime llvm-18-tools

# update-alternatives \
#   --install /usr/lib/llvm              llvm             /usr/lib/llvm-18  200 \
#   --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-18  \
#     --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-18 \
#     --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-18 \
#     --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-18 \
#     --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-18 \
#     --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-18 \
#     --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-18 \
#     --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-18 \
#     --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-18 \
#     --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-18 \
#     --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-18 \
#     --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-18 \
#     --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-18 \
#     --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-18 \
#     --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-18 \
#     --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-18 \
#     --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-18 \
#     --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-18 \
#     --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-18 \
#     --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-18 \
#     --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-18

# update-alternatives \
#   --install /usr/bin/clang                 clang                  /usr/bin/clang-18     200 \
#   --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-18 \
#   --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-18

#!/bin/bash
# set -e

# apt-get update && \
#     apt-get install -y make clang-9 llvm-9-dev libc++-9-dev libc++abi-9-dev \
#         build-essential git wget gcc-7-plugin-dev

# update-alternatives \
#   --install /usr/lib/llvm              llvm             /usr/lib/llvm-9  20 \
#   --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-9  \
#     --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-9 \
#     --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-9 \
#     --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-9 \
#     --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-9 \
#     --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-9 \
#     --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-9 \
#     --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-9 \
#     --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-9 \
#     --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-9 \
#     --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-9 \
#     --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-9 \
#     --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-9 \
#     --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-9 \
#     --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-9 \
#     --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-9 \
#     --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-9 \
#     --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-9 \
#     --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-9 \
#     --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-9 \
#     --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-9

# update-alternatives \
#   --install /usr/bin/clang                 clang                  /usr/bin/clang-9     20 \
#   --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-9 \
#   --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-9

set -e

apt-get install -y wget software-properties-common

# wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc
# sudo add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main"

apt-get update && \
    apt-get install -y make \
        build-essential git gcc-7-plugin-dev cmake git flex bison libglib2.0-dev libpixman-1-dev python3-setuptools cargo libgtk-3-dev

wget https://apt.llvm.org/llvm-snapshot.gpg.key
apt-key add llvm-snapshot.gpg.key
sudo add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main"
apt-get update  --fix-missing && \
    apt-get install -y make llvm-13 clang-13 llvm-13-dev

# wget https://llvm.org
# chmod +x llvm.sh
# sudo ./llvm.sh 13


update-alternatives \
  --install /usr/lib/llvm              llvm             /usr/lib/llvm-13  20 \
  --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-13  \
    --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-13 \
    --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-13 \
    --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-13 \
    --slave   /usr/bin/llvm-c-test       llvm-c-test      /usr/bin/llvm-c-test-13 \
    --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-13 \
    --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-13 \
    --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-13 \
    --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-13 \
    --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-13 \
    --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-13 \
    --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-13 \
    --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-13 \
    --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-13 \
    --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-13 \
    --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-13 \
    --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-13 \
    --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-13 \
    --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-13 \
    --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-13 \
    --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-13

update-alternatives \
  --install /usr/bin/clang                 clang                  /usr/bin/clang-13     20 \
  --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-13 \
  --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-13