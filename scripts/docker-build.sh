# Docker : Build the docker image
docker build \
    --build-arg GIT_TAG=$(git describe --tags) \
    -t darknet-cuda11.8:$(git describe --tags) \
    -t darknet-cuda11.8:latest .


