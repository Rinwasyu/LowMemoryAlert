while true
do
	free_result=$(free -m)
	mem_free=$(awk '{if($1 == "Mem:")print($4);}' <<< $free_result)
	if [ $mem_free -lt 1024 ]
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
