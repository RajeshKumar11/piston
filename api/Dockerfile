# Stage 1: Build and install isolate
FROM buildpack-deps:buster AS isolate
RUN apt-get update && \
    apt-get install -y --no-install-recommends git libcap-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/envicutor/isolate.git /tmp/isolate/ && \
    cd /tmp/isolate && \
    git checkout af6db68042c3aa0ded80787fbb78bc0846ea2114 && \
    make -j$(nproc) install && \
    rm -rf /tmp/*

# Stage 2: Main application setup
FROM node:15.10.0-buster-slim

# Configure environment to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Reconfigure dash (default shell) and install necessary packages
RUN dpkg-reconfigure -p critical dash && \
    apt-get update && \
    apt-get install -y libxml2 gnupg tar coreutils util-linux libc6-dev \
    binutils build-essential locales libpcre3-dev libevent-dev libgmp3-dev \
    libncurses6 libncurses5 libedit-dev libseccomp-dev rename procps python3 \
    libreadline-dev libblas-dev liblapack-dev libpcre3-dev libarpack2-dev \
    libfftw3-dev libglpk-dev libqhull-dev libqrupdate-dev libsuitesparse-dev \
    libsundials-dev libpcre2-dev libcap-dev && \
    rm -rf /var/lib/apt/lists/*

# Add user 'piston' without a home directory
RUN useradd -M piston

# Copy isolate binaries from the isolate stage
COPY --from=isolate /usr/local/bin/isolate /usr/local/bin
COPY --from=isolate /usr/local/etc/isolate /usr/local/etc/isolate

# Generate locale settings
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# Set up a directory for Piston related data with proper permissions
RUN mkdir -p /piston && chmod -R 777 /piston && chown -R piston:piston /piston

# Set up the working directory for the Node.js application
WORKDIR /piston_api

# Copy the package files and install dependencies
COPY ["package.json", "package-lock.json", "./"]
RUN npm install

# Copy the source code to the container
COPY ./src ./src

# Expose port 2000 for the application
EXPOSE 2000/tcp

# Set the default command to start the application
CMD ["/piston_api/src/docker-entrypoint.sh"]
