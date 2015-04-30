#!/bin/sh
#
#
# Script to automate the ECE4607 project
#
echo "Starting Simulations"


echo "NewReno TCP"

for i in  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
do
	echo "Rate = "$i
	sed 's/REPLACEHERE/'$i'/g' NewReno.tcl > NewReno_mod.tcl
	for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19	
	do
	sed 's/RRPP/'$j'/g' NewReno_mod.tcl
		ns NewReno_mod.tcl
		awk -f throughput.awk projout_newreno.nam >> out_newreno.txt
	done
	echo "" >> out_newreno.txt
done

echo "Reno TCP"

for i in  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
do
	echo "Rate = "$i
	sed 's/REPLACEHERE/'$i'/g' Reno.tcl > Reno_mod.tcl
	for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
	do
	sed 's/RRPP/'$j'/g' Reno_mod.tcl
		ns Reno_mod.tcl
		awk -f throughput.awk projout_reno.nam >> out_reno.txt
	done
	echo "" >> out_reno.txt
done

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

echo "Tahoe TCP"

for i in  0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0
do
	echo "Rate = "$i
	sed 's/REPLACEHERE/'$i'/g' Tahoe.tcl > Tahoe_mod.tcl
	for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
	do
	sed 's/RRPP/'$j'/g' Tahoe_mod.tcl
		ns Tahoe_mod.tcl
		awk -f throughput.awk projout_tahoe.nam >> out_tahoe.txt
	done
	echo "" >> out_tahoe.txt
done


