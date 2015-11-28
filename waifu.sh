#!/bin/bash
for i in old/*;
do
	echo -e "\e[1;36m$i\e[0m"
	if [ -f ./new/$i ];
	then
		echo $1passed;
	else
		waifu2x-converter-cpp --force-OpenCL --model_dir /usr/lib/waifu2x/model_rgb -j 2 --scale_ratio 1.5 --noise_level 1 -m noise_scale -i $i -o new/$i
	fi
done
