FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

# Ustaw ścieżkę dla bibliotek NVIDIA
ENV PATH="/usr/local/nvidia/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/nvidia/lib:/usr/local/nvidia/lib64"

# Add : Timezone as Europe/Warsaw
ENV TZ=Europe/Warsaw
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y tzdata

# Add : Aptutils and pkg-config
RUN apt-get update && apt-get install -y \
    apt-utils \
    pkg-config \
    curl \
    sudo

# Add : Build tools + Opencv dev 
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential make \
    libopencv-dev  

# Darknet COPY to workdir /darknet
COPY . /darknet
WORKDIR /darknet

# Darknet : Building
RUN ./install.sh




