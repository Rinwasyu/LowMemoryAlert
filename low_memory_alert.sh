#!/usr/bin/env bash

mem_min_limit=512 # (MB)

while true
do
	mem_free=$(free -m | awk '{if($1 == "Mem:")print($4);}')
	if [ $mem_free -lt $mem_min_limit ]
	then
		zenity \
			--text "メモリが少ないです\n残り"$mem_free"MBytes"\
			--timeout 5\
			--warning\
			--width 200\
			--height 100
	fi
	sleep 10s
done
