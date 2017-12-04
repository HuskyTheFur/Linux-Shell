#! /bin/bash

numrelays='2 3 14 17'
for i in $numrelays
do
	if [ -e /sys/class/gpio/gpio$i ]; then
		:
	else
		echo "$i" > /sys/class/gpio/export
		echo "out" > /sys/class/gpio/gpio$i/direction
	fi
done

echo "0" > counter
declare -a relays
relays=(/sys/class/gpio/gpio2/value /sys/class/gpio/gpio3/value /sys/class/gpio/gpio14/value /sys/class/gpio/gpio17/value)

relays_switching() {
while true
do	
	for i in ${relays[*]}
	do
		echo "1" > $i
		sleep 0.1
	done

	for i in ${relays[*]}
	do
		echo "0" > $i
		sleep 0.1
	done
done
}

relays_switching
