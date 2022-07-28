# Get name of trained YOLO
yoloname=$(ls backup/*last.weights | cut -c 8- | rev | cut -c 14- | rev)
echo "Found trained YOLO ${yoloname}!"
echo "darknet detector map cfg/${yoloname}.data cfg/${yoloname}.cfg backup/${yoloname}_best.weights -gpus 0,1"
darknet detector map cfg/${yoloname}.data cfg/${yoloname}.cfg backup/${yoloname}_best.weights -gpus 0,1
