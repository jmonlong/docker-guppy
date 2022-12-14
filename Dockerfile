# Set the base image to Ubuntu 18.04 and NVIDIA GPU
FROM nvidia/cuda:11.8.0-base-ubuntu18.04
CMD nvidia-smi

# Reference
# https://github.com/GenomiqueENS/dockerfiles/tree/master/guppy-gpu

# File Author / Maintainer
MAINTAINER Jean Monlong <jmonlong@ucsc.edu>

ARG PACKAGE_VERSION=6.3.8
ARG BUILD_PACKAGES="wget apt-transport-https"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install --yes $BUILD_PACKAGES libnvidia-compute-460-server && \ 
    cd /tmp && \
    wget -q --no-check-certificate https://mirror.oxfordnanoportal.com/software/analysis/ont_guppy_${PACKAGE_VERSION}-1~bionic_amd64.deb && \
    apt install --yes /tmp/ont_guppy_${PACKAGE_VERSION}-1~bionic_amd64.deb && \
    rm *.deb && \
    apt-get autoremove --purge --yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
