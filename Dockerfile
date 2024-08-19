# Use the base image
FROM debian:buster-slim

# Set environment variable for noninteractive installation
ENV DEBIAN_FRONTEND noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y unzip autoconf build-essential libssl-dev \
    pkg-config zlib1g-dev libargon2-dev libsodium-dev libcurl4-openssl-dev \
    sqlite3 libsqlite3-dev libonig-dev libxml2 libxml2-dev bc curl git \
    linux-headers-amd64 perl xz-utils python3 python3-pip gnupg jq zlib1g-dev \
    cmake cmake-doc extra-cmake-modules build-essential gcc binutils bash coreutils \
    util-linux pciutils usbutils coreutils binutils findutils grep libncurses5-dev \
    libncursesw5-dev python3-pip libgmp-dev libmpfr-dev python2 libffi-dev gfortran \
    libreadline-dev libblas-dev liblapack-dev libpcre3-dev libarpack2-dev libfftw3-dev \
    libglpk-dev libqhull-dev libqrupdate-dev libsuitesparse-dev libsundials-dev \
    libbz2-dev liblzma-dev libpcre2-dev gperf bison flex g++ gawk zip && \
    ln -sf /bin/bash /bin/sh && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2

# Copy the entire repo folder to the container
COPY repo /repo

# Make the scripts executable
RUN chmod +x /repo/entrypoint.sh /repo/mkindex.sh /repo/serve.py

# Set the working directory to the repo folder
WORKDIR /repo

# Set the entrypoint for the container
ENTRYPOINT ["bash", "/repo/entrypoint.sh"]

# Default command to run
CMD ["--no-build"]
