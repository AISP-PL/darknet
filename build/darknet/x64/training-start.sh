echo "Clear backup!"
rm -rfv backup.old/
mv backup backup.old
mkdir -p backup

choice=$(dialog --clear --backtitle "Select" \
       --title "YOLO model to training" --menu "Choose one of the following models:" \
       15 40 5 \
1 "YOLOv4-GDDKIA" \
2 "YOLOv4-ExtGDDKIA" \
3 "YOLOv4-ExtGDDKIA-lite" \
4 "YOLOv4-ALPR" \
5 "YOLOv4-GDDKIA-CSP" 3>&2 2>&1 1>&3)

clear
case ${choice} in
        1)
            model="yolov4.conv.137"
            datacfg="cfg/yolo-gddkia.data"
            modelcfg="cfg/yolo-gddkia.cfg"
            ;;
        2)
            model="yolov4.conv.137"
            datacfg="cfg/yolo-extgddkia.data"
            modelcfg="cfg/yolo-extgddkia.cfg"
            ;;
        3)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-extgddkialite.data"
            modelcfg="cfg/yolo-extgdkialite.cfg"
            ;;
        4)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-alpr.data"
            modelcfg="cfg/yolo-alpr.cfg"
            ;;
#       5)
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
