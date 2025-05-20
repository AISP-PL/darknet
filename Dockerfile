FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 AS builder

# Timezone setting
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Warsaw \
    PATH=/usr/local/nvidia/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone


# Additional dependencies for building Darknet
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       cmake \
       pkg-config \
       libopencv-dev \
       curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Darknet
WORKDIR /darknet
COPY . .
RUN chmod +x install.sh \
    && ./install.sh

# Stage 2: Runtime image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Timezone setting
ENV TZ=Europe/Warsaw \
    PATH=/usr/local/nvidia/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone
    
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        libopencv-core4.5 \
        libopencv-imgproc4.5 \
        libopencv-highgui4.5 \
        libopencv-videoio4.5 \
        libopencv-imgcodecs4.5 \
        libgtk-3-0 \
&& rm -rf /var/lib/apt/lists/*


# Copy the compiled Darknet from the builder stage
WORKDIR /darknet
COPY --from=builder /darknet .


