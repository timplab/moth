#!/bin/bash 
#install 

if [ "$1" == "install" ]; then
	conda create --name mummer_env
	source activate mummer
	conda install -c bioconda mummer 
fi 

if [ "$1" == "split" ]; then
dir='/kyber/Data/temp/gmoney/moth/assemblies'
split -b 100m ${dir}/moth_wtdbg2_clean_pilon.fasta wtdbg 
split -b 100m ${dir}/moth_canu_clean_pilon.fasta canu
here=''
file=$(find /home/gmoney/Code/moth -name)
  for i in $file
  do
    echo $i
  done
fi

if [ "$1" == "mummer" ]; then
source activate mummer
qseq=/kyber/Data/temp/gmoney/moth/assemblies
nucmer -p moth_mum ${qseq}/moth_wtdbg2_clean_pilon.fasta ${qseq}/moth_canu_clean_pilon.fasta
fi 
 #  ~/Code/mummer-4.0.0beta/mummerplot --png -p wga/${i}.layout.spades wga/${i}.spades.delta -l -R NC_016845.fasta -Q ${qseq}
  #  ~/Code/mummer-4.0.0beta/mummerplot --png -p wga/${i}.spades wga/${i}.spades.delta


  #  ~/Code/mummer-4.0.0beta/mummerplot --postscript -p wga/${i}.layout.spades wga/${i}.spades.delta -l -R NC_016845.fasta -Q ${qseq}
  #  ~/Code/mummer-4.0.0beta/mummerplot --postscript -p wga/${i}.spades wga/${i}.spades.delta

