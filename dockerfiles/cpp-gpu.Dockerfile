FROM 01e9/ide-in-docker:cpp

RUN apt-get update \
    && apt-get install -y \
        # GPU/OpenGL
        libglfw3-dev libassimp-dev libxinerama-dev libxcursor-dev libxi-dev xorg-dev libgl1-mesa-dev mesa-utils mesa-utils-extra kmod libxxf86vm-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
