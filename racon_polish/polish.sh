#!/bin/bash 

indir=/home/ubuntu/assemblies
outdir=/home/ubuntu/assemblies/alignments
fastq=./181005_moth_decontam.fastq

#flye_assembly.fasta  moth_clean.contigs.fasta  moth_clean_wt.fa
if [ "$1" == "aln" ]; then
       	minimap2 -d ${indir}/canu_ref.mmi ${indir}/moth_clean.contigs.fasta
	minimap2 -d ${indir}/wt_ref.mmi ${indir}/moth_clean_wt.fa
	minimap2 -d ${indir}/flye_ref.mmi ${indir}/flye_assembly.fasta
	
	minimap2 -t 72 -ax map-ont ${indir}/canu_ref.mmi $fastq | samtools view -S -b  | samtools sort -o ${outdir}/canu.align.bam
	samtools index ${outdir}/canu.align.bam
	minimap2 -t 72 -ax map-ont ${indir}/wt_ref.mmi $fastq | samtools view -S -b  | samtools sort -o ${outdir}/wt.align.bam
	samtools index ${outdir}/wt.align.bam
	minimap2 -t 72 -ax map-ont ${indir}/flye_ref.mmi $fastq | samtools view -S -b  | samtools sort -o ${outdir}/flye.align.bam
	samtools index ${outdir}/flye.align.bam
fi

if [ "$1" == "cat" ]; then
	sumdir=/home/ubuntu/summary
        out=/home/ubuntu/summaryCAT.txt
        sums=$(find $sumdir -name "*txt")
        cat $sums | awk 'NR==1||$1!="filename"{ print }' > $out
fi


if [ "$1" == "index" ]; then
	/home/ubuntu/nanopolish/nanopolish index -d /home/ubuntu/fast5_reads -s /home/ubuntu/summaryCAT.txt  $fastq &> index.log
fi

if [ "$1" == "canu" ]; then
	out='/home/ubuntu/polished_vcf/'
	python /home/ubuntu/nanopolish/scripts/nanopolish_makerange.py ${indir}/moth_clean.contigs.fasta | parallel --results nanopolish_canu.results -P 4 \
		 /home/ubuntu/nanopolish/nanopolish variants --consensus -o ${out}/canu_vcf/polished_canu.{1}.vcf -w {1} -r $fastq -b ~/assemblies/alignments/canu.align.bam -g ${indir}/moth_clean.contigs.fasta -t 6 --min-candidate-frequency 0.1
fi

if [ "$1" == "wt" ]; then
        out='/home/ubuntu/polished_vcf/'
        python /home/ubuntu/nanopolish/scripts/nanopolish_makerange.py ${indir}/moth_clean_wt.fa | parallel --results nanopolish_wt.results -P 4 \
                 /home/ubuntu/nanopolish/nanopolish variants --consensus -o ${out}/wt_vcf/polished_wt.{1}.vcf -w {1} -r $fastq -b ~/assemblies/alignments/wt.align.bam -g ${indir}/moth_clean_wt.fa -t 6 --min-candidate-frequency 0.1
fi

if [ "$1" == "flye" ]; then
        out='/home/ubuntu/polished_vcf/'
        python /home/ubuntu/nanopolish/scripts/nanopolish_makerange.py ${indir}/flye_assembly.fasta | parallel --results nanopolish_flye.results -P 4 \
                 /home/ubuntu/nanopolish/nanopolish variants --consensus -o ${out}/flye_vcf/polished_flye.{1}.vcf -w {1} -r $fastq -b ~/assemblies/alignments/flye.align.bam -g ${indir}/flye_assembly.fasta -t 6 --min-candidate-frequency 0.1
fi

if [ "$1" == "merge" ]; then
	/home/ubuntu/nanopolish/nanopolish vcf2fasta -g ${indir}/moth_clean.contigs.fasta /home/ubuntu/polished_vcf/canu_vcf/polished_canu.*.vcf > canu_moth_polished_genome.fa
	/home/ubuntu/nanopolish/nanopolish vcf2fasta -g ${indir}/moth_clean_wt.fa /home/ubuntu/polished_vcf/wt_vcf/polished_wt.*.vcf > wt_moth_polished_genome.fa
	/home/ubuntu/nanopolish/nanopolish vcf2fasta -g ${indir}/flye_assembly.fasta /home/ubuntu/polished_vcf/flye_vcf/polished_flye.*.vcf > fly_moth_polished_genome.fa
fi
