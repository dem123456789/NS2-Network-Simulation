#!/bin/sh
#
#
# Script to automate the ECE4607 project
#
echo "Starting Simulations"


echo "Sack TCP"

for i in  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
do
	echo "Rate = "$i
	sed 's/REPLACEHERE/'$i'/g' Sack.tcl > Sack_mod.tcl
	for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
	do
	sed 's/RRPP/'$j'/g' Sack_mod.tcl
		ns Sack_mod.tcl
		awk -f throughput.awk projout_sack.nam >> out_sack.txt
	done
	echo "" >> out_sack.txt
done




