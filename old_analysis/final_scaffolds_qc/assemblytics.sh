#!/bin/bash
ref=/kyber/Data/temp/gmoney/moth/ncbi_assembly/ncbi_assembly_moth.fasta
qry=/kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/wt_moth_corrected_scaffolds.fasta

#~/repos/mummer-4.0.0beta2/nucmer --maxmatch -l 100 -c 500 $ref $qry
~/repos/mummer-4.0.0beta2/delta-filter /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/corrected_baylor.delta > filtered.delta
~/repos/mummer-4.0.0beta2/mummerplot filtered.delta
