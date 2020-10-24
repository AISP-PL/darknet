#!/bin/bash

echo "Starting training pre-configured yolov4!"
./darknet detector train data/obj.data yolo-obj.cfg yolov4.conv.137
