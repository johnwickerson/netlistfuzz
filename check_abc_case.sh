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
NumofCra=0
NumofErr=0
NumofSucc=0
for loop in $(seq 1 10)
do
./abc -c "rv rtl/expression_0000$loop.v; b; ps; cec; quit;"
while getopts "equivalent:crash" arg;do
echo "Hello"
case "$arg" in
	equivalent)
		((NumofSucc++))
		;;
	crash)
		((NumofCra++))
		;;
	*)
		((NumofErr++))
		;;
esac
done
echo "Number of Crashes"
echo $NumofCra
echo "NUmber of Error"
echo $NumofErr
echo "Number of success"
echo $NumofSucc
#-c source synth.scr
echo "Iteration:"
echo $loop
done
