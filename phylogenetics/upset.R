library(ggplot2)
library(UpSetR)
library(tidyverse)
library(GOplot)
library(venneuler)
figs="/uru/Data/Nanopore/projects/moth/2020_analysis/figures"

orthos <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Orthogroups/Orthogroups.GeneCount.tsv") %>%
  dplyr::select(-c(Total)) %>%
 # select(-c(GCF_000330985.1_DBM_FJ_V1.1_protein)) %>%
  column_to_rownames(var = "Orthogroup") %>%
  dplyr::rename("silkworm" = GCF_000151625.1_ASM15162v1_protein) %>%
  dplyr::rename("diamondback_moth" = GCF_000330985.1_DBM_FJ_V1.1_protein) %>%
  dplyr::rename("common_mormon" = GCF_000836215.1_Ppol_1.0_protein) %>%
  dplyr::rename("Asian_swallowtail" = GCF_000836235.1_Pxut_1.0_protein) %>%
  dplyr::rename("monarch_butterfly" = GCF_009731565.1_Dplex_v4_protein) %>%
  dplyr::rename("Tobacco_hornworm" = Stringtie_liftoff_Msex_protein)
rownames(orthos) <- orthos[,1]


tmp <- orthos
tmp$Orthogroup <- rownames(orthos)

list <- lapply(colnames(orthos), function(x) {
  tmp[tmp[[x]] > 0, "Orthogroup"]
})
names(list) <- colnames(orthos)


p1 <- upset(fromList(list), number.angles = 15, point.size = 3.5, line.size = 2, order.by = c("freq"), cutoff = 6, sets.bar.color = "#56B4E9",  mainbar.y.label = "Gene orthogroups", sets.x.label = "Orthogroup size", text.scale = 2, nsets = 6)


pdf(file=paste0(figs, "/upset.pdf"), height = 10, width = 20) 
p1
dev.off()
