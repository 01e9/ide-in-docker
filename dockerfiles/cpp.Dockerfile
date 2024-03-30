FROM 01e9/ide-in-docker

ARG CMAKE_VERSION='3.28.3'
ARG NINJA_VERSION='1.11.1'
ARG GCC_VERSION='13'
ARG LLVM_VERSION='18'
ARG CPPCHECK_HTMLREPORT_VERSION='2.8'

RUN apt update \
    && apt install -y \
        # Build
        make g++ automake autoconf \
        # Debug
        gdb gdbserver \
        # Code analysis
        gcovr cppcheck python3-pygments valgrind \
        # Libs
        libssl-dev \
    # cmake
    && cd /tmp \
        && wget -O cmake.tar.gz https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
        && tar -xf cmake.tar.gz \
        && cd cmake-* \
        && mv bin/* /usr/local/bin/ \
        && mv share/* /usr/local/share/ \
    # ninja
    && cd /tmp \
        && wget -O ninja.zip https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip \
        && unzip ninja.zip \
        && mv ninja /usr/local/bin/ \
    # gcc
    && cd /tmp \
        && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
        && apt install -y gcc-${GCC_VERSION} g++-${GCC_VERSION} \
    # llvm (clang)
    && cd /tmp \
        && wget https://apt.llvm.org/llvm.sh \
        && bash llvm.sh ${LLVM_VERSION} all \
    # cppcheck-htmlreport
    && wget -O /usr/local/bin/cppcheck-htmlreport https://raw.githubusercontent.com/danmar/cppcheck/${CPPCHECK_HTMLREPORT_VERSION}/htmlreport/cppcheck-htmlreport \
        && chmod +x /usr/local/bin/cppcheck-htmlreport \
        && chmod 755 /usr/local/bin/cppcheck-htmlreport \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/*
