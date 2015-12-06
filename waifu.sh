#!/bin/bash
##  _LXY_'s Scripts
##  Waifu2x 图片处理:github/nagadomi/waifu2x
##  此处使用的是 github/WL-Amigo/waifu2x-converter-cpp 的改进版。
##  很简陋的一个实用的小程序~
##########
# 请在此处设置时间 (秒)
# 而且请输入10的整倍数字(10、20、30)
time=30

for i in old/*;
do
	echo -e "\e[1;36m$i\e[0m"
	if [ -f ./new/$i ];
	then
		echo $1passed;
	else
		waifu2x-converter-cpp --force-OpenCL --model_dir /mnt/0/work/models -j 2 --scale_ratio 1.5 --noise_level 1 -m noise_scale -i $i -o new/$i
		echo `date +%F_%T` $i
		while [[ $? > 0 ]];
		do
			echo `date +%F_%T` $i Conversion Failed >> waifu2xerror.log
			rm new/$i 
			waifu2x-converter-cpp --force-OpenCL --model_dir /mnt/0/work/models -j 2 --scale_ratio 1.5 --noise_level 1 -m noise_scale -i $i -o new/$i
		done
	fi
done
mkdir -p video/30
nice -6 ffmpeg -framerate 59.970 -i new/out/%4d.png -c:v libx264rgb -qp0 -preset slow video/$time/$time.mkv
nice -6 ffmpeg -framerate 59.970 -i new/out/%4d.png -c:v libx264    -crf 21 -preset slow video/$time.mkv
ttime=0
rm file.txt
touch file.txt
while [[ $ttime != $time ]];
do
	ttime=`expr $ttime + 10`
	echo "file video/$ttime.mkv">>file.txt
done
nice -6 ffmpeg -f concat -i file.txt -i in2.mp3 -c:v copy -c:a copy -t $time out$time.mkv
rm file.txt
