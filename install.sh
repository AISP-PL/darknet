#mkdir build_release
#cd build_release
#cmake ..
#cmake --build . --target install --parallel 8
make -j9 clean
make -j9
echo "Compiled."


# Install libraries
sudo ln -sf $(pwd)/darknet /usr/bin/darknet
sudo cp -rfv libdarknet.so /usr/local/lib/
sudo cp -rfv include/darknet.h /usr/local/include/
sudo ldconfig
echo "Installed in system."
