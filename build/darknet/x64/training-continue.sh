
# If number of GPU given as an argument
if [ $# -eq 1 ]; then
    gpus=${1}
# Else automatic get number of GPU's
else
    gpus=$(lspci | grep VGA.*NVIDIA | wc -l)
fi

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

# Get name of trained YOLO
yoloname=$(ls backup/*last.weights | cut -c 8- | rev | cut -c 14- | rev)
# trace info
echo "Found trained YOLO ${yoloname}!"
echo "Found ${gpus}!"
echo "GPU argument is ${gpuArg}"
sleep 1
darknet detector train cfg/${yoloname}.data cfg/${yoloname}.cfg backup/${yoloname}_last.weights -map ${@} -gpus ${gpuArg} -clear
