#!/bin/bash 
#hisat2-build /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/hisat_index/moth_canu_nanopolish_racon1.FINAL 



#bowtie2-build /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/bowtie_index/moth_canu_nanopolish_racon1.FINAL.fasta

bowtie2-build /uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna /uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/bowtie_index/GCF_000262585.1_Msex_1.0_genomic.fna
index=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/bowtie_index/moth_canu_nanopolish_racon1.FINAL.fasta
if [ "$1" == "single" ]; then
	in=/uru/Data/Nanopore/projects/moth/2020_analysis/larry_rna/mirna/small_RNA
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/larry_rna/mirna/small_RNA/trim
	bam=/uru/Data/Nanopore/projects/moth/2020_analysis/larry_rna/mirna/small_RNA/bam
	single=$(ls -d $in/*/)
	for i in $single; do
		f=$(basename $i)
		echo $f
		echo $i
#		~/repos/TrimGalore-0.6.5/trim_galore ${i}/result_primary/${f}.fq --fastqc -a CGACAGGTTCAGAGTTCTACAGTCCGACGATC -a TGGAATGTAAAGAAGTATGGAGCTGTAGGCACCATCAATGCCAATATCTCGTATGC -j 30 --quality 20 -o ${out} 
#	trimmomatic SE ${i}/result_primary/${f}.fq ${out}/${f}_out.fastq  -threads 50 ILLUMINACLIP:${in}/solexa_adapter.txt:2:30:10 -trimlog ${out}/${f}.log SLIDINGWINDOW:4:15 LEADING:3 TRAILING:3 MINLEN:20
#		hisat2 -x /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/hisat_index/moth_canu_nanopolish_racon1.FINAL -p 48 -U ${i}result_primary/clean.fa | samtools view -b | samtools sort -o ${bam}/$f.bam &> ${bam}/${f}_alignment.log
	bowtie2 -p 24 -x $index -D 20 -R 3 -N 0 -L 7 -i S,1,0.50 -f ${i}result_primary/clean.fa | samtools view -b | samtools sort -o ${bam}/$f.bam &> ${bam}/${f}_alignment.log	
	samtools index ${bam}/$f.bam
	bowtie2 -p 24 -x /uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/bowtie_index/GCF_000262585.1_Msex_1.0_genomic.fna -D 20 -R 3 -N 0 -L 7 -i S,1,0.50 -f ${i}result_primary/clean.fa | samtools view -b | samtools sort -o ${bam}/${f}_Msex_ref.bam &> ${bam}/${f}_alignment.log
	samtools index ${bam}/${f}_Msexref.bam
	done
fi
#--np 0 --n-ceil L,0,0.02 --rdg 0,6 --rfg 0,6 --mp 6,2 --score-min L,0,-0.18 
