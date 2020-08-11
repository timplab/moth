#!/bin/bash
repo=~/repos/mirlo
in=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/species_compare/orthofinder/OrthoFinder/Results_Jun16/Orthogroups/Orthogroups.tsv
seq_dir=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/species_compare/orthofinder
out=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/species_compare/orthofinder/mirlo

python2 ${repo}/mirlo.py -c $in -t 30 -o $out 
