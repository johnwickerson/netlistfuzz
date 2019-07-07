#!/bin/bash
set -e

mkdir -p check_abc
rm -f check_abc/${1}_abc.txt

rm -rf temp/check_abc_$1

checkifcontained() {
    reqsubstr="$1"
    shift
    string="$@"
    if [ -z "${string##*$reqsubstr*}" ] ;then
        return 0
      else
        return 1
    fi
}

#cat > synth.scr <<- EOT
#	read_verilog half_adder.v;
#	b;
#	ps;
#	cec;
#EOT
for loop in $(seq 1 10)
do
# MY_VAR=$(./abc -c "rv rtl/expression_0000$loop.v; b; ps; cec; quit;")
MY_VAR=$(./abc -c "rv half_adder.v; b; ps; cec; quit;")

omit=false
if checkifcontained 'equivalent' $MY_VAR; then
    omit=true
fi
if ! $omit; then 
    echo $MY_VAR
fi
#-c source synth.scr
echo "Iteration:"
echo $loop
done
