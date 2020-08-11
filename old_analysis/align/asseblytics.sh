#!/bin/bash 

old=/kyber/Data/temp/gmoney/moth/ncbi_assembly/ncbi_assembly_moth.fasta
ref=/kyber/Data/temp/gmoney/moth/hiC/assemblies
out=/kyber/Data/temp/gmoney/moth/nanopolished_assemblies/racon_assemblies/nucmer_out


file=$(find $ref -name "*.fa")
for i in $file
do
	echo $i
	basename "$i"
	f=$(basename "$i" .fa)
	echo $f
	mkdir ${out}/${f}
#	/home/gmoney/repos/mummer-4.0.0beta2/nucmer --maxmatch -l 100 -c 500 $i $old --delta=${out}/${f}/${f}.delta
	~/repos/Assemblytics/Assemblytics ${out}/${f}/${f}.delta $f 10000 ~/repos/Assemblytics
done
