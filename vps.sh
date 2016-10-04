#!/bin/bash
#破vb写的东西还在这瞎扯=￣ω￣=
#填写区
username='xxxxx'
password='xxxxx'
site='www.mianfeiidc.com'
vpsid=106737
#填写区完
tmp_cookie=`tempfile`
tmp_cookie=./cookie
function wget_c() {
	echo $site$1
	wget -q --load-cookies="$tmp_cookie" --keep-session-cookies --save-cookies="$tmp_cookie" -O /dev/null "$2" http://"$site$1"
	sleep 0.5s 
}
#模拟访问主页
wget_c
wget_c '/idc/top_login.asp'
#登录
#模拟输密码过程
echo Login...
sleep 5s
wget_c '/user/usertop_login.asp' --post-data="username=$username&password=$password&Submit.x=$((RANDOM%72+1))&Submit.y=$((RANDOM%20+1))"
wget_c '/idc/top_login.asp'
#模拟进入客户区
wget_c '/user/logininfo.asp'
#模拟进入VPS管理
wget_c '/user/vpsadm.asp'
#模拟进入VPS续费前页面
wget_c "/user/vpsadm2.asp?id=$vpsid&go=c"
#模拟5秒延时
echo +1s...
sleep 5
wget_c "/vpsadm/selfvpsmodifyrepay.asp?id=$vpsid"
#续费
wget_c '/vpsadm/selfvpsmodifyendtime.asp' --post-data="year=9007&moneynow=0&id=$vpsid&Submit=%C2%ED%C9%CF%D0%F8%C6%DA"
#清理cookie
rm $tmp_cookie
