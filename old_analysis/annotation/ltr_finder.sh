#!/bin/bash 

/home/gmoney/repos/LTR_Finder/source/ltr_finder /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.fasta -P moth_final -w2 -f /dev/stderr 2>&1 > /kyber/Data/Nanopore/Analysis/gmoney/moth/annotation/ltr_finder/moth_LTR_result.txt 
#| perl ~/repos/LTR_Finder/source/genome_plot.pl moth/
