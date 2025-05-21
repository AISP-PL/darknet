 #Run the docker container with the GPU support
docker run --rm \
           --hostname $(hostname) \
           --gpus all \
           --env NVIDIA_DRIVER_CAPABILITIES="compute,utility,video" \
           -it darknet-cuda11.8:latest bash
