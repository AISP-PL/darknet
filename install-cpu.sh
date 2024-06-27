#!/bin/bash

# Make sure the Makefile exists
if [[ ! -f Makefile ]]; then
    echo "Makefile not found!"
    exit 1
fi


# Install dependencies
sudo apt-get update
sudo apt-get install -y sudo libgomp1
sudo apt-get install -y libopencv-dev

# Use sed to replace the necessary lines
sed -i 's/GPU=1/GPU=0/' Makefile
sed -i 's/CUDNN=1/CUDNN=0/' Makefile
sed -i 's/CUDNN_HALF=1/CUDNN_HALF=0/' Makefile
sed -i 's/AVX=0/AVX=1/' Makefile
sed -i 's/OPENMP=0/OPENMP=1/' Makefile

echo "Makefile updated for CPU+AVX+OPENMP compilation without CUDA."


#mkdir build_release
#cd build_release
#cmake ..
#cmake --build . --target install --parallel 8
make -j9 clean
make -j9
# Check compilation status
if [[ $? -ne 0 ]]; then
    echo "Compilation failed!"
    exit 1
fi

echo "Compiled."


# Install libraries
sudo ln -sfv $(pwd)/darknet /usr/bin/darknet
sudo cp -rfv $(pwd)libdarknet.so /usr/local/lib/
sudo cp -rfv include/darknet.h /usr/local/include/
sudo ldconfig
echo "Installed in system."
