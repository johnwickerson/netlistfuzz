#!/bin/bash
set +e

mkdir -p check_abc
NumofCra=0
NumofErr=0
NumofSucc=0
iter=0
for loop in $(seq 0 99)
do
./abc -c "rv rtl/expression_$loop.v; strash; rewrite; ps; cec; quit;" > ./check_abc/abc_$loop.txt
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
iter=$((loop + 1))
#done
echo "Number of Crashes"
echo $NumofCra
echo "NUmber of Error"
echo $NumofErr
echo "Number of success"
echo $NumofSucc
#-c source synth.scr
echo "Iteration:"
echo $iter
done
