tmap <- read_tsv("/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie2/stringtie2_merge/Msexta_augustus_liftoff.Msexta_liftoff.gtf.tmap") #%>%
  #filter(class_code == "k" | class_code == "u" | class_code == "j" | class_code == "=")

unmapped <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/liftoff/unmapped_features.txt", col_names = F)

# align the unmapped lifoff genes to the "u" + keep "u" that also have evidence from the augustus annotation

# keep original annotations for "=" because they are the same and functions will transfer 

# for K keep the stringtie gene model becuase it encompasses the reference, but transfer the name/function

sizes <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/chrom.sizes", col_names = F)

ref_unmapped <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.gff", skip = 8, col_names = F) %>%
  filter(X3 == "gene") %>%
  separate(X9, sep = ";", into = c("ID", "parent","ref"), extra = "warn", fill = "warn") %>%
  mutate(ID = str_remove(ID, "ID=")) %>%
  mutate(liftoff = ifelse(ID %in% unmapped$X1, "unmapped", "mapped")) %>%
  mutate(len = X5 - X4)

ref <- inner_join(ref_unmapped, sizes, by = "X1") %>%
  rename(X2.y = "contig_len") 


ggplot(data = ref, aes(x = len, y = liftoff, fill = liftoff))+geom_boxplot()+xlim(0,20000)+theme_bw()
ggplot(data = ref, aes(x = contig_len, y = liftoff, fill = liftoff))+geom_boxplot()+xlim(0,100000)+theme_bw()

ggplot(data = ref, aes(x = len))+geom_density()
# K and U is what is interesting to us, K we want to keep the stringtie transcript with the liftoff annotation
# U we want to decide which are "real" unannotated transcripts and add those to the annotation
ggplot(data = tmap, aes(x = class_code))+geom_bar(stat = "count")+geom_text(stat='count', aes(label=..count..), vjust=-1)


compare <- read_tsv("/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/liftoff/compare_stats.txt")

ggplot(data = compare, aes(x = stat, y= sensitivity, fill = annotation))+geom_bar(stat = "identity", position = "dodge")+theme_classic()

ggplot(data = compare, aes(x = stat, y= precision, fill = annotation))+geom_bar(stat = "identity", position = "dodge")+theme_classic()

ggplot(data = tmap, aes(x = len, fill = class_code))+geom_histogram()+facet_wrap(~class_code)
