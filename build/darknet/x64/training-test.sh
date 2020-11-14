imagepath="${1}"
imagename=$(basename ${imagepath})
outimagename="test.${imagename}"
cp ${imagepath} ${outimagename}

convert ${outimagename} -resize 1280\> ${outimagename}
darknet detector test data/obj.data cfg/yolo-obj.cfg backup/yolo-obj_last.weights ${outimagename}
# clean
rm -rfv ${outimagename}

