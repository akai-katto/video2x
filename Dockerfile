# Name: Video2X Dockerfile
# Creator: Danielle Douglas
# Date Created: Unknown
# Last Modified: January 14, 2020

# Editor: Lhanjian
# Last Modified: May 24, 2020

# Editor: K4YT3X
# Last Modified: June 13, 2020

# using Ubuntu LTS 19.10
# Ubuntu 20.x is incompatible with Nvidia libraries
FROM ubuntu:19.10

# file mainainter labels
LABEL maintainer="Danielle Douglas <ddouglas87@gmail.com>"
LABEL maintainer="Lhanjian <lhjay1@foxmail.com>"
LABEL maintainer="K4YT3X <k4yt3x@k4yt3x.com>"

# run installation
RUN apt-get update \
    && apt-get install -y git-core \
    && git clone --recurse-submodules --progress https://github.com/k4yt3x/video2x.git /tmp/video2x/video2x \
    && bash -e /tmp/video2x/video2x/src/video2x_setup_ubuntu.sh /
    
RUN apt-get install -y wget
RUN apt-get install -y zip
RUN mkdir /host
RUN wget https://github.com/nihui/waifu2x-ncnn-vulkan/releases/download/20200606/waifu2x-ncnn-vulkan-20200606-linux.zip
RUN unzip waifu2x-ncnn-vulkan-20200606-linux.zip
RUN mv waifu2x-ncnn-vulkan-20200606-linux /host/waifu2x-ncnn-vulkan
RUN rm waifu2x-ncnn-vulkan-20200606-linux.zip
RUN ls

WORKDIR /host/waifu2x-ncnn-vulkan
ENTRYPOINT ["/host/waifu2x-ncnn-vulkan"]
ENV NVIDIA_DRIVER_CAPABILITIES all
ENV DEBIAN_FRONTEND teletype
