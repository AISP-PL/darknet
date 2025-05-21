# Stage 1: Builder image
# -------------------------------------------
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 AS builder

# Timezone setting
ENV TZ=Europe/Warsaw \
    PATH=/usr/local/nvidia/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# Timezone link
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# APT : Dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       cmake \
       pkg-config \
       libopencv-dev \
    && rm -rf /var/lib/apt/lists/*

# Darknet : Compile and strip
WORKDIR /darknet
COPY . .
RUN make -j$(nproc) clean \
    && make -j$(nproc) \
    && strip -s libdarknet.so \
    && strip -s darknet 

# Stage 2: Runtime image
# -------------------------------------------
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

# Timezone setting
ENV TZ=Europe/Warsaw \
    PATH=/usr/local/nvidia/bin:${PATH} \
    LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64

# Timezone link
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone
    
# APT : Dependencies
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        libopencv-core4.5 \
        libopencv-imgproc4.5 \
        libopencv-videoio4.5 \
        libopencv-imgcodecs4.5 \
&& rm -rf /var/lib/apt/lists/*


# Darknet : Copy files from builder
COPY --from=builder /darknet/libdarknet.so /usr/local/lib/libdarknet.so
COPY --from=builder /darknet/include/darknet.h /usr/local/include/darknet.h
COPY --from=builder /darknet/darknet /usr/bin/darknet
RUN ldconfig



