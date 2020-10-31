#!/bin/bash

echo "Starting training pre-configured yolov4!"
./darknet detector train build/darknet/x64/data/obj.data cfg/yolo-obj.cfg yolov4.conv.137
