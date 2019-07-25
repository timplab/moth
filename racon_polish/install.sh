#!/bin/bash 

#sudo apt-get install libbz2-dev
#sudo apt-get install zlib1g-dev
#sudo apt-get install libncurses5-dev 
#sudo apt-get install libncursesw5-dev
#sudo apt-get install liblzma-dev

cd /usr/bin
sudo wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2
tar -vxjf htslib-1.9.tar.bz2
cd htslib-1.9
make

cd ..
sudo wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2
tar -vxjf bcftools-1.9.tar.bz2
cd bcftools-1.9
make


