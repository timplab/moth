in=/uru/Data/Nanopore/projects/moth/sra_rna_data/paired
out=/uru/Data/Nanopore/projects/moth/old_assembly
fastq=/uru/Data/Nanopore/projects/moth/trim
#hisat2-build /uru/Data/Nanopore/projects/moth/old_assembly/ms_scaffolds.fa /uru/Data/Nanopore/projects/moth/old_assembly/ms_scaffolds


paired_files=$(ls $in | grep 1.fastq)

for i in $paired_files; do
	f=$(basename $i _1.fastq)
	echo $f
	hisat2 -x /uru/Data/Nanopore/projects/moth/old_assembly/ms_scaffolds -1 ${fastq}/paired/${f}_1_out_paired.fq -2 ${fastq}/paired/${f}_2_out_paired.fq --dta-cufflinks -p 15 -S ${out}/${f}.sam
	done


