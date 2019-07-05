#!/bin/bash
set +e

mkdir -p check_abc
#rm -f check_abc/abc.txt

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
	#> abc.txt
#./abc -c "rv rtl/expression_0000$loop.v; b; ps; cec; quit;" > ../check_abc/${1}_abc.txt
./abc -c "rv half_adder.v; b; ps; cec; quit;" > ./check_abc/abc_$loop.txt
echo "Hello"
grep "equivalent" ./check_abc/abc_$loop.txt
equ=$?
equ=$((1 - equ))
grep "crash" ./check_abc/abc_$loop.txt
cra=$?
cra=$((1 - cra))

case "$equ" in
	1)
		NumofSucc=$((NumofSucc + 1))
	;;
	*)
	if [$cra -eq 1]; then
		NumofCra=$((NumofCra + 1))
	else
		NumofErr=$((NumofErr + 1))
	fi
	;;
esac

#done
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