echo "Test YOLO on validation dataset!"
darknet detector valid data/obj.data cfg/yolo-obj.cfg backup/yolo-obj_last.weights -map
