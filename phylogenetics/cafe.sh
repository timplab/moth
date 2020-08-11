#!/bin/bash 
dir=/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Orthogroups
fam=/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Orthogroups/Orthogroups.GeneCount.tsv
tree=/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Species_Tree/SpeciesTree_rooted.txt
repo=~/repos/CAFE/bin/cafexp
#estimate lambda
cut -f1,2,3,4,5,6,7 $fam | awk 'BEGIN{FS=OFS="\t"} {print (NR>1?"null":"Desc"), $0}' > ${dir}/Orthogroups.GeneCount_formatted.tsv

${repo} -i ${dir}/Orthogroups.GeneCount_formatted.tsv -t $tree 
