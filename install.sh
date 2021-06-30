mkdir build_release
cd build_release
cmake ..
cmake --build . --target install --parallel 8

sudo ln -sf /home/spasz/python/pyAITracker/darknet/darknet /usr/bin/darknet
