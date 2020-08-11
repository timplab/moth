# for each iteration of racon track changes with mummer show-snps

library(tidyverse)

racon1 <- read_tsv("/kyber/Data/Nanopore/Analysis/gmoney/moth/racon_changes/racon_1_snps", skip = 4, col_names = F) %>%
  select(c(X1, X2, X3, X4, X9)) %>%
  rename(ref_pos = X1, ref_snp = X2, qry_snp = X3, qry_pos = X4, contig = X9) %>%
  group_by(contig) %>%
  tally() %>%
  mutate(rep = "one")

all_tigs <- racon1 %>%
  select(contig)


racon2 <- read_tsv("/kyber/Data/Nanopore/Analysis/gmoney/moth/racon_changes/racon_2_snps", skip = 4, col_names = F) %>%
  select(c(X1, X2, X3, X4, X9)) %>%
  rename(ref_pos = X1, ref_snp = X2, qry_snp = X3, qry_pos = X4, contig = X9)%>%
  group_by(contig) %>%
  tally() %>%
  mutate(rep = "two")

#zeros = subset(racon2$contig, !(all_tigs$contig %in% racon2$contig))
#zeros<-zeros[!is.na(zeros)]
#
#n <- rep(0, length(zeros))
#rep <- rep("two", length(zeros))
#newdat <- data.frame(contig = zeros, n = n, rep = rep)
#newdat <- droplevels(newdat)
#
#racon2 <- rbind(newdat, racon2)

racon3 <- read_tsv("/kyber/Data/Nanopore/Analysis/gmoney/moth/racon_changes/racon_3_snps", skip = 4, col_names = F) %>%
  select(c(X1, X2, X3, X4, X9)) %>%
  rename(ref_pos = X1, ref_snp = X2, qry_snp = X3, qry_pos = X4, contig = X9)%>%
  group_by(contig) %>%
  tally() %>%
  mutate(rep = "three")

polish <- rbind(racon1, racon2, racon3)
polish$rep <- as.factor(polish$rep)
polish$rep=factor(polish$rep , levels=levels(polish$rep)[c(1,3,2)])

ggplot(data = polish, aes(x = rep, y = n, fill = rep)) + geom_boxplot(notch = T) + ylim(0,25000) + theme_classic() + labs(x = "Racon polishing iterations", y = "Bases changed per contig")
