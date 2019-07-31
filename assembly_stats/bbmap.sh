#!/bin/bash 
datadir=/kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds

~/repos/bbmap/stats.sh in=/kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.fasta gchist=moth_gchist shist=moth_shist gcbins=200 n=10 k=13 
