#!/bin/bash 
fastq=/kyber/Data/NGS/projects/moth_hiC/grcf/timp1-mothHiC_redemux/FASTQ
/home/gmoney/repos/TrimGalore-0.6.0/trim_galore --hardtrim5 75 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_1.fastq -o /kyber/Data/NGS/projects/moth_hiC/grcf/75bp_trimmed
/home/gmoney/repos/TrimGalore-0.6.0/trim_galore --hardtrim5 75 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_2.fastq -o /kyber/Data/NGS/projects/moth_hiC/grcf/75bp_trimmed

