library(tidyverse)
rm(list=ls());gc()


figs="/uru/Data/Nanopore/projects/moth/2020_analysis/figures"
scaffold <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/sizes.genome", col_names = F) %>%
  mutate(asm = "scaffold") %>%
  arrange(desc(X2)) %>%
  mutate(ID = row_number()) %>%
  mutate(cumbp=cumsum(as.numeric(X2)))

scaffold.stat <- summarize(scaffold, n50=X2[which.min(abs(cumbp-max(cumbp)/2))],
                           tot.yield=max(cumbp),
                           tot.reads=n(),
                           med.len=median(X2),
                           max.len=max(X2),
                           q75=quantile(X2, .75),
                           q95=quantile(X2, .95))
chroms <- scaffold %>%
  slice(1:28) 

max(chroms$cumbp)/scaffold.stat$tot.yield

contig <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/nanopolished/scaffold.sizes", col_names = F) %>%
  mutate(asm = "contig")%>%
  arrange(desc(X2)) %>%
  mutate(ID = row_number())

ref <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/chrom.sizes", col_names = F) %>%
  mutate(asm = "old")%>%
  arrange(desc(X2)) %>%
  mutate(ID = row_number())

dat <- rbind(scaffold, contig, ref)

p1 <- ggplot(data = dat, aes(x = ID, y = (X2)/1000000, color = asm))+geom_step()+scale_y_log10()+theme_bw()

#ggsave(paste0(figs, "/NGx_all.pdf"), p1, height = 3, width = 5)

p2 <- ggplot(data = dat, aes(x = ID, y = (X2)/1000000, color = asm))+geom_step()+xlim(0,100)+theme_bw()+scale_y_log10()
#ggsave(paste0(figs, "/NGx_zoom.pdf"), p2, height = 3, width = 5)

stats <- dat %>%
  summarise()