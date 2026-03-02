FROM ubuntu:25.10

ARG TZ_REGION='Europe'
ARG TZ_CITY='Chisinau'

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
    && apt-get install -y \
        # Essential
        tini wget tar unzip git curl nano man htop build-essential socat gnupg2 locales \
          software-properties-common bash-completion openssh-server apparmor apparmor-utils \
        # GUI
        qt6-base-dev dmz-cursor-theme libgtk2.0-0 libxext6 libxrender1 libxtst6 libxslt1.1 fonts-dejavu-core \
            # KDE
            kde-style-breeze breeze-cursor-theme \
        # Wayland
        qt6-wayland libwayland-client0 libwayland-cursor0 libwayland-egl1 libxkbcommon0 wayland-protocols weston \
        # X11
        xorg xserver-xorg-core xserver-xorg-video-all xserver-xorg-input-all xinit x11-xserver-utils xdotool dbus-x11 xterm wmctrl \
        # GPU
        libglfw3-dev libassimp-dev libxinerama-dev libxcursor-dev libxi-dev xorg-dev libgl1-mesa-dev mesa-utils mesa-utils-extra mesa-vulkan-drivers kmod libxxf86vm-dev \
        # for VsCode
        libxcb-dri3-0 libdrm-dev libgbm-dev \
        # for Chromium
        libgtk-3-0 libatk-bridge2.0-0 libx11-xcb1 libnss3 libxss1 \
        # for browsers/playwright
        libgtk-4-1 libwoff1 libgstreamer-plugins-bad1.0-0 libharfbuzz-icu0 libenchant-2-2 libhyphen0 libmanette-0.2-0 \
        # for JetBrains
        libxshmfence-dev \
        # web browser
        libkf5coreaddons5 libkf5i18n5 libkf5guiaddons5 falkon \
    # tzdata
    && truncate -s0 /tmp/preseed.cfg \
        && echo "tzdata tzdata/Areas select ${TZ_REGION}" >> /tmp/preseed.cfg \
        && echo "tzdata tzdata/Zones/${TZ_REGION} select ${TZ_CITY}" >> /tmp/preseed.cfg \
        && debconf-set-selections /tmp/preseed.cfg \
        && rm -f /etc/timezone /etc/localtime \
        && apt-get install -y tzdata \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN locale-gen en_US.UTF-8

RUN mkdir -p ~/.ssh \
    && ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

ENTRYPOINT ["tini", "--"]

CMD ["sleep", "infinity"]
