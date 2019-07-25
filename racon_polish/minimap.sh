#!/bin/bash
indir='/kyber/Data/temp/gmoney/moth/nanopore'
assembly='/kyber/Data/temp/gmoney/moth/assemblies'
outdir='/kyber/Data/temp/gmoney/moth/nanopore/alignments'


if [ "$1" == "aln" ]; then
    minimap2 -d ${outdir}/moth_canu_ref.mmi ${assembly}/moth_canu_clean_pilon.fasta
    minimap2 -d ${outdir}/moth_wt_ref.mmi ${assembly}/moth_wtdbg2_clean_pilon.fasta
    minimap2 -t 4 -ax map-ont ${outdir}/moth_canu_ref.mmi ${indir}/181005_moth_decontam.fastq |
    samtools view -b  | samtools sort -o moth_canu.bam
    samtools index moth_canu.bam
    minimap2 -t 4 -ax map-ont ${outdir}/moth_wt_ref.mmi ${indir}/181005_moth_decontam.fastq |
    samtools view -b  | samtools sort -o moth_wt.bam
    samtools index moth_wt.bam
fi

