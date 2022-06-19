FROM 01e9/ide-in-docker

ARG CPPCHECK_HTMLREPORT_VERSION='2.8'

RUN apt-get update \
    && apt-get install -y \
        # Build
        make g++ cmake automake autoconf \
        # Development
        gdb gdbserver \
        # Code analysis
        gcovr cppcheck python-pygments valgrind \
    # cppcheck-htmlreport
    && wget -O /usr/local/bin/cppcheck-htmlreport https://raw.githubusercontent.com/danmar/cppcheck/${CPPCHECK_HTMLREPORT_VERSION}/htmlreport/cppcheck-htmlreport \
        && chmod +x /usr/local/bin/cppcheck-htmlreport \
        && chmod 755 /usr/local/bin/cppcheck-htmlreport \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
