#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Arguments (classes)."
    exit -1
fi

classes="${1}"

#Download pre-trained yolov4 weights
if [ ! -e yolov4.conv.1237 ]; then
    wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.conv.137 
fi

# Configure yolo-obj cfg
cp cfg/yolov4-custom.cfg cfg/yolo-obj.cfg
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

