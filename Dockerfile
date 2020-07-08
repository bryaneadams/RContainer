FROM r-base:latest as dse-r
RUN apt-get update -qq && apt-get upgrade -qq
RUN apt-get install -yq --no-install-recommends \
        wget \
        zlib1g \
        libssh2-1-dev \
        libbz2-dev \
        liblzma-dev \
        libpcre3 libpcre3-dev \
        libxml2-dev \
        libfreetype6-dev \
        zlib1g-dev && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# pre-stage R package installs
COPY packageInstaller.R /tmp/packageInstaller.R
COPY dsePackages.R /tmp/dsePackages.R
RUN cd /tmp/
RUN R -f /tmp/packageInstaller.R