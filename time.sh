#!/bin/bash

start=$(date +%S%N)
#%N is nano second
sh check_abc_test.sh

end=$(date +%S%N)
cost=$((($end - start)/1000000))
echo "Time cost is $cost" 
