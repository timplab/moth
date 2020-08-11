
# compare percent of aligned reads within 8 RNa-seq datasets between our final assembly and the Baylor assembly
library(tidyverse)
library(reshape2)

aligned <-as.numeric(c(97.4,
             98.16,
             97.74,
             97.46,
             97.45,
             97.45,
             97.82,
             97.46
))

asm <- "our_asm"

us <- cbind(aligned, asm)

aligned <- as.numeric(c(77.41,
                86.01,
                77.29,
                63.06,
                88.31,
                79.56,
                82.32,
                84.98
))

asm <- "baylor_asm"

old <- cbind(aligned, asm)

dat <- as.data.frame(rbind(us, old))

dat$aligned <- as.character(dat$aligned)
dat$aligned <- as.numeric(dat$aligned)

ggplot(dat, aes(asm, aligned, fill = asm))+geom_violin()+geom_jitter(height = 0, width = 0.1)+theme_classic(base_size = 25)+labs(x = "Assembly", y = "Percent aligned RNA-seq reads") 

