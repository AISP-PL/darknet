imagepath="${1}"
imagename=$(basename ${imagepath})
outimagename="test.${imagename}"
cp ${imagepath} ${outimagename}

convert ${outimagename} -resize 1280\> output.png
darknet detector test data/obj.data cfg/yolo-obj.cfg backup/yolo-obj_last.weights output.png
# clean
rm -rfv output.png ${outimagename}

