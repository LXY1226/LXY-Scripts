#!bin/bash
ptha=$1
for name in pool/*.mp4 
	do
		pvname=${name/初音ミク Project DIVA Arcade Future Tone }
		pv=${pvname/ PV*}
		if [ -d "$pv" ]; then mkdir "$pv"; fi
		echo "$pvname"
		mv "pool/$name" "$pv/$pvname"
		size=`stat -c %s "$pv/$pvname"`
		printf MD5... 
		md5=`md5sum <"$pv/$pvname"`
		md5=${md5/  -}
		md5=`echo $md5|tr [:lower:] [:upper:]`
		printf SHA...
		sha=`shasum <"$pv/$pvname"`
		sha=${sha/  -}
		sha=`echo $sha|tr [:lower:] [:upper:]`
		printf CRC...
		crc=`crc32 "$pv/$pvname"`
		crc=`echo $crc|tr [:lower:] [:upper:]`
		echo "$pv,$pvname,$size,$md5,$sha,$crc">>List.csv
		printf "Done!\n"
	done
for rar in download/*.rar;
do
	if ![ -d pool ]; then mkdir pool; fi
	unrar e -y "download/$rar" pool/
	if [ $? = 0 ]; then rm "download/$rar"; fi
	for name in pool/*.mp4 
	do
		pvname=${name/初音ミク Project DIVA Arcade Future Tone }
		pv=${pvname/ PV*}
		if [ -d "$pv" ]; then mkdir "$pv"; fi
		echo "$pvname"
		mv "pool/$name" "$pv/$pvname"
		size=`stat -c %s "$pv/$pvname"`
		printf MD5... 
		md5=`md5sum <"$pv/$pvname"`
		md5=${md5/  -}
		md5=`echo $md5|tr [:lower:] [:upper:]`
		printf SHA...
		sha=`shasum <"$pv/$pvname"`
		sha=${sha/  -}
		sha=`echo $sha|tr [:lower:] [:upper:]`
		printf CRC...
		crc=`crc32 "$pv/$pvname"`
		crc=`echo $crc|tr [:lower:] [:upper:]`
		echo "$pv,$pvname,$size,$md5,$sha,$crc">>List.csv
		printf "Done!\n"
	done
done
