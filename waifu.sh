#!/bin/bash
##  _LXY_'s Scripts
##  Waifu2x 图片处理:github/nagadomi/waifu2x
##  此处使用的是 github/WL-Amigo/waifu2x-converter-cpp 的改进版。
##  很简陋的一个实用的小程序~
for i in old/*;
do
	echo -e "\e[1;36m$i\e[0m"
	if [ -f ./new/$i ];
	then
		echo $1passed;
	else
		waifu2x-converter-cpp --force-OpenCL --model_dir /mnt/0/work/models -j 2 --scale_ratio 1.5 --noise_level 1 -m noise_scale -i $i -o new/$i
		while [[ $? > 0 ]];
		do
			echo `date +%F_%T` $i Conversion Failed >> waifu2xerror.log
			rm new/$i 
			waifu2x-converter-cpp --force-OpenCL --model_dir /mnt/0/work/models -j 2 --scale_ratio 1.5 --noise_level 1 -m noise_scale -i $i -o new/$i
		done
	fi
done
