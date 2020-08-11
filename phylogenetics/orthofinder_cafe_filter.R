library(tidyverse)
sigs <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/cafe_results/Base_family_results.txt") %>%
  filter(pvalue <= .05)

#counts <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/cafe_results/Base_change.tab") %>%
#  filter(FamilyID %in% sigs$`#FamilyID`)

counts <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Orthogroups/Orthogroups.GeneCount.tsv")

manduca_pos <- counts %>%
  filter(`Stringtie_liftoff_Msex_protein<2>` > 0)

ortho_counts <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/species_compare/orthofinder/OrthoFinder/Results_Jul23_1/Orthogroups/Orthogroups.GeneCount.tsv") %>%
  filter(Orthogroup %in% manduca_pos$FamilyID) %>%
  dplyr::select(-c(Total)) %>%
  arrange(desc(Stringtie_liftoff_Msex_protein)) %>%
  dplyr::slice(5:10)

library(reshape)
ortho_counts <- as.data.frame(ortho_counts)
count_melt <- melt(ortho_counts, id="Orthogroup") 


ggplot(data = count_melt, aes(x = Orthogroup, y = value, fill = variable))+ geom_bar(stat = "identity", position = "dodge") + theme_classic() +coord_flip()+geom_text(aes(label = value), position=position_dodge(width=0.9), hjust=-.2)+scale_fill_brewer(palette="Dark2")

