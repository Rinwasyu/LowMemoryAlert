#!/usr/bin/env bash

warning_memoryLimit=512 # (MB)
# Auto kill (Danger!)
autokill_isEnabled=false
autokill_memoryLimit=48
autokilling_processes=('chromium' 'chromium-browse' 'helloworld')

while true
do
	mem_free=$(free -m | awk '{if($1 == "Mem:")print($4);}')
	if [ $mem_free -lt $warning_memoryLimit ]
	then
		if $autokill_isEnabled
		then
			if [ $mem_free -lt $autokill_memoryLimit ]
			then
				for name in ${autokilling_processes[@]}
				do
					kill $(pgrep -l $name | awk -v name=$name '{if($2==name)print($1);}')
				done
			fi
		fi
		zenity \
			--text "Memory is low.\n"$mem_free"MBytes remaining."\
			--timeout 5\
			--warning\
			--width 200\
			--height 100
	fi
	sleep 10s
done
