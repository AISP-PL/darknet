# Get number of GPU's
gpus=$(lspci | grep VGA.*NVIDIA | wc -l)
if [ ${gpus} -eq 0 ]; then
    echo "Error! Missing GPU!"
    exit -1
elif [ ${gpus} -eq 1 ]; then 
    gpuArg="0"
elif [ ${gpus} -eq 2 ]; then 
    gpuArg="0,1"
elif [ ${gpus} -eq 3 ]; then 
    gpuArg="0,1,2"
elif [ ${gpus} -eq 4 ]; then 
    gpuArg="0,1,2,3"
fi

echo "Found ${gpus}!"
echo "GPU argument is ${gpuArg}"
sleep 1
darknet detector train data/obj.data cfg/yolo-obj.cfg backup/yolo-obj_last.weights -map ${@} -gpus ${gpuArg}
