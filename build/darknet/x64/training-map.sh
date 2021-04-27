# Get name of trained YOLO
yoloname=$(ls backup/*last.weights | cut -c 8- | rev | cut -c 14- | rev)
echo "Found trained YOLO ${yoloname}!"
darknet detector map data/obj.data cfg/${yoloname}.cfg backup/${yoloname}_best.weights -gpus 0,1
