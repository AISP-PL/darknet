#!/bin/bash
# Arguments check
if [ $# -lt 1 ]; then
    echo "Missing yolov4 sufix name. Give (sufixname)."
    exit -1
fi
sufix="${1}"

output="../example1-yolo/ObjectDetectors/yolov4${sufix}"
mkdir -p ${output}/cfg

cp -rfv build/darknet/x64/cfg/yolo-obj.cfg ${output}/cfg/yolov4.cfg
cp -rfv build/darknet/x64/backup/yolo-obj_last.weights ${output}/cfg/yolov4.weights
cp -rfv build/darknet/x64/data/obj.data ${output}/cfg/${sufix}.data
cp -rfv build/darknet/x64/data/obj.names ${output}/cfg/${sufix}.names

