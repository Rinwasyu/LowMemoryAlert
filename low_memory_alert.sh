#!/usr/bin/env bash

warning_limit=512 # (MB)
# Auto kill (Danger!)
autokill_enable=false
autokill_limit=48
autokill_processes=('chromium-browse' 'helloworld')

while true
do
	mem_free=$(free -m | awk '{if($1 == "Mem:")print($4);}')
	if [ $mem_free -lt $warning_limit ]
	then
		if $autokill_enable
		then
			if [ $mem_free -lt $autokill_limit ]
			then
				for name in ${autokill_processes[@]}
				do
					kill $(pgrep -l $name | awk -v name=$name '{if($2==name)print($1);}')
				done
			fi
		fi
		zenity \
			--text "メモリが少ないです\n残り"$mem_free"MBytes"\
			--timeout 5\
			--warning\
			--width 200\
			--height 100
	fi
	sleep 10s
done
