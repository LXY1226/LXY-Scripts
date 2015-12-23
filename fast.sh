#!/bin/bash
in=$1
echo "File:$in"
duration=`mediainfo --output='Video;%Duration%' $in`
framerate=`mediainfo --output='Video;%FrameRate%' $in`
duration=`echo 'scale=3;'$duration' / 1000'|bc`
echo "Duration: ${duration}s"
dur_s=
echo "Get Start..."
if [[ ! -d png ]]; then mkdir png; fi
ffmpeg -i $in -t 10 png/%d.png
for frame in {1..600}; do 
sizea=`stat -c%s png/$frame.png`
isa=`echo $sizea' < '102400 | bc`
	if [[ $isa = 1 ]];then {
	frame_1=`expr $frame + 1`
	sizeb=`stat -c%s png/$frame_1.png`
	isb=`echo $sizeb' > '102400 | bc`
	if [[ $isb = 1 ]];then {
		dur_s=`echo 'scale=3;'$frame' / '$framerate|bc`
		echo "File:$in" >> log.log >&2
		echo "Start Time:$dur_s" >> log.log >&2
	}; fi
	}; fi
if [[ $dur_s != "" ]]; then break;fi;
done
duration_e=`echo 'scale=3;'$duration' - 10'|bc`

ffmpeg -i $in -ss $duration_e png/%d.png
for frame in {600..1}; do 
sizea=`stat -c%s png/$frame.png`
isa=`echo $sizea' < '102400 | bc`
	if [[ $isa = 1 ]];then {
	frame_1=`expr $frame - 1`
	sizeb=`stat -c%s png/$frame_1.png`
	isb=`echo $sizeb' > '102400 | bc`
	if [[ $isb = 1 ]];then {
		dur_e=`echo 'scale=3;'$frame' / '$framerate|bc`
		echo $frame
		echo "End Time: $dur_e" >> log.log >&2
		dur=`echo $duration_e' + '$dur_e' - '$dur_s | bc`
		echo "Duration: $dur" >> log.log >&2
	}; fi
	}; fi
if [[ $dur_e != "" ]]; then break;fi;
done
if [[ ! -d finished ]]; then mkdir finished; fi
ffmpeg -i $in -ss $dur_s -t $dur -c:a copy -c:v libx264 -crf 12 -preset fast -metadata Author="Repacked By. LXY" finished/${in%%.*}.mkv