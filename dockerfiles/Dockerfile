FROM ubuntu:25.04

ARG TINI_VERSION='0.19.0'
ARG TZ_REGION='Europe'
ARG TZ_CITY='Chisinau'

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
    && apt-get install -y \
        # Essential
        wget tar unzip git curl nano man htop build-essential socat gnupg2 watchman \
          software-properties-common bash-completion openssh-server apparmor apparmor-utils \
        # GUI
        kde-plasma-desktop libgtk2.0-0 libxext6 libxrender1 libxtst6 libxslt1.1 dmz-cursor-theme \
        # for VsCode
        libxcb-dri3-0 libdrm-dev libgbm-dev \
        # for Chromium
        libgtk-3-0 libatk-bridge2.0-0 libx11-xcb1 libnss3 libxss1 \
        # for browsers/playwright
        libgtk-4-1 libwoff1 libgstreamer-plugins-bad1.0-0 libharfbuzz-icu0 libenchant-2-2 libhyphen0 libmanette-0.2-0 \
        # for JetBrains
        libxshmfence-dev \
	# web browser
        falkon \
    # utf8
    && apt-get install -y locales \
        && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    # tzdata
    && truncate -s0 /tmp/preseed.cfg \
        && echo "tzdata tzdata/Areas select ${TZ_REGION}" >> /tmp/preseed.cfg \
        && echo "tzdata tzdata/Zones/${TZ_REGION} select ${TZ_CITY}" >> /tmp/preseed.cfg \
        && debconf-set-selections /tmp/preseed.cfg \
        && rm -f /etc/timezone /etc/localtime \
        && apt-get install -y tzdata \
    # tini
    && wget -O /tini "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" \
        && chmod +x /tini \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# GPU
RUN apt-get update \
    && apt-get install -y \
        libglfw3-dev libassimp-dev libxinerama-dev libxcursor-dev libxi-dev xorg-dev libgl1-mesa-dev mesa-utils mesa-utils-extra kmod libxxf86vm-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.utf8

RUN mkdir -p ~/.ssh \
    && ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

ENTRYPOINT ["/tini", "--"]

CMD ["sleep", "infinity"]
