
echo "Clear backup!"
rm -rfv backup.old/
mv backup backup.old

echo "Start training!"
darknet detector train data/obj.data cfg/yolo-obj.cfg yolov4.conv.137 -map
