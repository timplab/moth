library(tidyverse)
library(pheatmap)
dir="/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/functions/interproscan/interproscan_other_genomes/files_for_plot"


#NORMALIZE TO TOTAL NUMBER OF GENES!!!!

files <- list.files(dir)


dat <- data.frame(X2 = character())

for (i in 1:length(files))
  {
  
  print(files[i])
  ipr <- read_tsv(paste0(dir, "/", files[i]), col_names = F) %>%
    unite(X2, c("X2", "X3"), sep = "-") %>%
    drop_na() %>%
    distinct() %>%
    group_by(X2) %>%
    count(X2) %>%
    ungroup() 
  
  
  dat <- full_join(dat, ipr, by = "X2", copy = FALSE, suffix = c(".x", ".y"))


}

dat <- dat %>%
  column_to_rownames(var = "X2")

names(dat) <- files
dat[is.na(dat)] <- 0

  

mat <- as.matrix(dat)
mat = mat - rowMeans(mat) 
dat2 <- as.data.frame(mat) %>%
  arrange(desc(msexta.tsv))

mat <- as.matrix(dat2[1:30,])

# Subtract the row means from each value

# add row and column names
rownames(df) = colnames(mat) 
# plot heatmap
colors = colorRampPalette( rev(brewer.pal(9, "RdBu")))
pheatmap(mat,  cellwidth = 20, cellheight = 10)





