# 1. Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# 2. Install base build tools and dependencies
RUN apt-get update && \
    apt-get install -y \
        make \
        build-essential \
        git \
        gcc-7-plugin-dev \
        cmake \
        flex \
        bison \
        libglib2.0-dev \
        libpixman-1-dev \
        python3-setuptools \
        cargo \
        libgtk-3-dev \
        software-properties-common \
        wget

# 3. Add the LLVM 13 repository (Ubuntu 18.04 / bionic)
RUN wget https://apt.llvm.org/llvm-snapshot.gpg.key && \
    apt-key add llvm-snapshot.gpg.key && \
    add-apt-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-13 main"


# 4. Install LLVM 13, Clang 13, and related tools
RUN apt-get update --fix-missing && \
    apt-get install -y \
        llvm-13 \
        clang-13 \
        llvm-13-dev \
        lld-13 

# 5. Set update-alternatives for LLVM
RUN update-alternatives \
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

# 6. Set update-alternatives for Clang
RUN update-alternatives \
  --install /usr/bin/clang                 clang                  /usr/bin/clang-13     20 \
  --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-13 \
  --slave   /usr/bin/clang-cpp             clang-cpp              /usr/bin/clang-cpp-13

# 7. Copy the local folder (the entire build context) into the image at /workdir
COPY ./fuzzers/insopt/repo /workdir

# 8. Set working directory
WORKDIR /workdir

# 9. Run the makefile in the copied folder (Optional)
# RUN make
