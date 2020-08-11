#!/bin/bash 

chrs=$(cut -f2 scaffold.sizes | sort -n -r | head -n 28 | awk '{sum+=$1} END {print sum}')
total=$(cut -f2 scaffold.sizes | awk '{sum+=$1} END {print sum}')
echo $chrs bases in 28 scaffolds
echo $total bases in all scaffolds

percent=$(echo "scale = 2 ; $chrs / $total" | bc)

echo $percent of bases within 28 scaffolds
