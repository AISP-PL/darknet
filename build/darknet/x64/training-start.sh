echo "Clear backup!"
rm -rfv backup.old/
mv backup backup.old
mkdir -p backup

choice=$(dialog --clear --backtitle "Select" \
       --title "YOLO model to training" --menu "Choose one of the following models:" \
       15 40 5 \
1 "YOLOv4-GDDKIA" \
2 "YOLOv4-ExtGDDKIA" \
3 "YOLOv7-ExtGDDKIA (v7)" \
4 "YOLOv4-ExtGDDKIA-lite" \
5 "YOLOv4-ALPROCR" \
6 "YOLOv4-ExtGDDKIA-CSP" \
7 "YOLOv4-VehliceFeatures" 3>&2 2>&1 1>&3)

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
            model="yolov7.conv.132"
            datacfg="cfg/yolov7-extgddkia.data"
            modelcfg="cfg/yolov7-extgddkia.cfg"
            ;;
        4)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-extgddkialite.data"
            modelcfg="cfg/yolo-extgddkialite.cfg"
            ;;
        5)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-alpr.data"
            modelcfg="cfg/yolo-alpr.cfg"
            ;;
        6)
            model="yolov4-csp.conv.142"
            datacfg="cfg/yolo-extgddkia-csp.data"
            modelcfg="cfg/yolo-extgddkia-csp.cfg"
            ;;
        7)
            model="yolov4-tiny.conv.29"
            datacfg="cfg/yolo-vehlicefeatures.data"
            modelcfg="cfg/yolo-vehlicefeatures.cfg"
            ;;
        *)
            echo "Error! Unknown ${choice}!"
            exit -1
            ;;
esac

echo "Start training!"
echo "Training with ${model}, ${modelcfg}."
darknet detector train ${datacfg} ${modelcfg} ${model} -map
