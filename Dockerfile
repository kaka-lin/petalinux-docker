FROM ubuntu:18.04
LABEL maintainer="kaka <vn503024@gmail.com>"

# Ubuntu 18.04: tzdata issue
# set noninteractive installation

RUN dpkg --add-architecture i386

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    tzdata locales sudo pkg-config \
    git wget vim unzip \
    # Build essentials
    build-essential cmake ninja-build g++ \
    python3-dev python3-pip python3-setuptools \
    # petalinux
    gawk \
    net-tools \
    xterm \
    autoconf \
    libtool \
    texinfo \
    zlib1g-dev \
    zlib1g:i386 \
    gcc-multilib \
    libncurses5-dev

RUN apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Set timezone
ENV TZ=Asia/Taipei
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Set locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Add group & user 'petalinux' + sudo
# and give it access to install directory /opt
RUN groupadd -r petalinux && \
    useradd -m -g petalinux -G audio,video petalinux && \
    echo 'petalinux ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/petalinux && \
    chown -R petalinux:petalinux /opt && \
    mkdir /opt/petalinux && \
    chmod 755 /opt/petalinux && \
    chown -R petalinux:petalinux /opt/petalinux

# Install PetaLinux
USER petalinux
ADD data/petalinux-v2020.2-final-installer.run /opt/petalinux/petalinux-v2020.2-final-installer.run
WORKDIR /opt/petalinux
RUN sudo chown -R petalinux:petalinux . && \
    chmod +x /opt/petalinux/petalinux-v2020.2-final-installer.run && \
    echo "y" | SKIP_LICENSE=y ./petalinux-v2020.2-final-installer.run -d /opt/petalinux && \
    rm -f petalinux-v2020.2-final-installer.run && \
    rm -f petalinux_installation_log

# Source PetaLinux environment
RUN echo "source /opt/petalinux/settings.sh" >> ~/.bashrc

WORKDIR /home/petalinux
ENV HOME /home/petalinux
