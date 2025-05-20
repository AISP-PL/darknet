 #Run the docker container with the GPU support
docker run --rm \
           --hostname $(hostname) \
           --gpus all,capabilities=video \
           darknet-cuda11.8:latest
