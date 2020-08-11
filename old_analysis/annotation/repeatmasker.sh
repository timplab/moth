#!/bin/bash
qry=/kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.fasta

/usr/local/RepeatMasker/RepeatMasker -parallel 35 -s -a small -u -gff -xm $qry

