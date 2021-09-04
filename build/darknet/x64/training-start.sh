echo "Clear backup!"
rm -rfv backup.old/
mv backup backup.old
mkdir -p backup

choice=$(dialog --clear --backtitle "Select" \
       --title "YOLO model to training" --menu "Choose one of the following models:" \
       15 40 4 \
1 "YOLOv4-GDDKIA" \
2 "YOLOv4-plates" \
3 "YOLOv4-GDDKIA-CSP" 3>&2 2>&1 1>&3)

clear
case ${choice} in
        1)
            model="yolov4.conv.137"
            datacfg="cfg/yolo-gddkia.data"
            modelcfg="cfg/yolo-gddkia.cfg"
            ;;
        2)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-plates.data"
            modelcfg="cfg/yolo-plates.cfg"
            ;;
#       3)
#            model="yolov4-csp.conv.142"
#            modelcfg="cfg/yolov4-csp.cfg"
#            ;;
        *)
            echo "Error! Unknown ${choice}!"
            exit -1
            ;;
esac

echo "Start training!"
echo "Training with ${model}, ${modelcfg}."
darknet detector train ${datacfg} ${modelcfg} ${model} -map
