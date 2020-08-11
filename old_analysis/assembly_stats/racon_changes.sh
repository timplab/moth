#!/bin/bash 
in=/kyber/Data/temp/gmoney/moth/nanopolished_assemblies
out=/kyber/Data/Nanopore/Analysis/gmoney/moth/racon_changes
~/repos/mummer-4.0.0beta2/nucmer -p nucmer1 ${in}/wt_moth_polished_genome.fa ${in}/racon_assemblies/wt_moth_racon1.fa
~/repos/mummer-4.0.0beta2/show-snps -C -T -r nucmer1.delta > ${out}/racon_1_snps

~/repos/mummer-4.0.0beta2/nucmer -p nucmer2 ${in}/racon_assemblies/wt_moth_racon1.fa ${in}/racon_assemblies/wt_moth_racon2.fa
~/repos/mummer-4.0.0beta2/show-snps -C -T -r nucmer2.delta > ${out}/racon_2_snps

~/repos/mummer-4.0.0beta2/nucmer -p nucmer3 ${in}/racon_assemblies/wt_moth_racon2.fa ${in}/racon_assemblies/wt_moth_racon3.fa
~/repos/mummer-4.0.0beta2/show-snps -C -T -r nucmer3.delta > ${out}/racon_3_snps
