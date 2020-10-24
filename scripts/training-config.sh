#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Arguments (classes)."
    exit -1
fi

classes="${1}"

# Configure yolo-obj cfg
if [ ! -e  cfg/yolo-obj.cfg ]; then
    cp -rfv cfg/yolov4-custom.cfg cfg/yolo-obj.cfg
fi
max_batches=$((${classes}*2000))
step1=$((${max_batches}*8/10))
step2=$((${max_batches}*9/10))
filters=$(((${classes}+5)*3))
echo "max_batches=${max_batches}"
echo "steps=${step1},${step2}"
echo "filters=${filters}"
echo "classes=${classes}"

# Write object names
touch build/darknet/x64/data/obj.names
echo "Write names to build/darknet/x64/data/obj.names"

# Data
touch build/darknet/x64/data/obj.data
cat <<EOF >> build/darknet/x64/data/obj.data
classes = ${classes}
train  = data/train.txt
valid  = data/test.txt
names = data/obj.names
backup = backup/
EOF

# Images 
echo "Copy your images to build\darknet\x64\data\obj\ !"
echo "Next, mark your images with Yolo_mark!"


#Download pre-trained yolov4 weights
if [ ! -e ./build/darknet/x64/yolov4.conv.1237 ]; then
    echo "Downloading pre-trained weights!"
    wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.conv.137
    mv -fv yolov4.conv.137 build\darknet\x64
fi
