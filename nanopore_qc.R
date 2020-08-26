##Ok - this is an R to do qc from nanopore fastq


##Default input variable
sampdir="/kyber/Data/Nanopore/projects/moth/SRA_data"
modif="blah"


##Plots go here:
#plotdir=file.path(sampdir)


##Load libraries and sources
library(Biostrings) 
library(ShortRead)
library(ggplot2)
library(reshape2)
library(plyr)
library(tidyverse)

fastq=dir(path=sampdir, pattern="*fastq", full.names=T)

fq=readFastq(fastq)


##Read length plot

r.length=tibble(len=width(fq)) %>%
    arrange(len) %>%
    mutate(cumbp=cumsum(as.numeric(len)))

stat.sum=summarize(r.length, n50=len[which.min(abs(cumbp-max(cumbp)/2))],
                   tot.yield=max(cumbp),
                   tot.reads=n(),
                   med.len=median(len),
                   max.len=max(len),
                   q75=quantile(len, .75),
                   q95=quantile(len, .95))

print(ggplot(r.length, aes(x=len, weight = len, y = stat(count/1e6)))+geom_histogram(bins=100, fill="orange")+scale_x_log10()+geom_vline(xintercept=stat.sum$n50, color="blue", size=1)+
    annotate("text", label =paste0("N50= ", stat.sum$n50/1e3, " kb"), x=stat.sum$n50, y= Inf, vjust=2,  hjust=-0.1, color="blue")+theme_classic()+labs(x= "Read length", y = "Number of bases (Mb)"))







