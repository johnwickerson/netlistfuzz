#!/bin/bash
set -e

mkdir -p check_abc
rm -f check_abc/${1}_abc.txt

rm -rf temp/check_abc_$1

#cat > synth.scr <<- EOT
#	read_verilog half_adder.v;
#	b;
#	ps;
#	cec;
#EOT
NumOfCra=0
for loop in $(seq 1 10)
do
i=$(./abc -c "rv half_adder.v; b; ps; cec; quit;" | grep -c "equivalent")
#j=grep -c 'crash'
if [ $i -ne 0 ]
then
	NumOfCra=$(expr $NumOfCra + 1)
fi
echo "Number of Crashes"
echo $NumOfCra
#echo "NUmber of Error"
#echo $NumofErr

#-c source synth.scr
echo "Iteration:"
echo $loop
done
