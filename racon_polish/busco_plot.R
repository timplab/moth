
library(ggplot2)
library(tidyverse)
dat <- read_csv("/uru/Data/Nanopore/projects/moth/2020_analysis/racon/racon_iterations.csv")
figs="/uru/Data/Nanopore/projects/moth/2020_analysis/figures"
rest <- dat %>%
  dplyr::select(-c("n")) %>%
  filter(busco != "complete") %>%
  dplyr::select(c("busco", "percent", "database", "polishing")) %>%
  filter(database != "metazoa") %>%
  filter(polishing == "raw" | polishing == "racon1" | polishing == "nanopolish")

text <- " C:98.4%[S:88.4%,D:10.0%],F:0.2%,M:1.4%,n:1367"
busco <- c("single_copy", "duplicated", "fragmented", "missing")
percent <- c(88.4,10.0,0.2,1.4)
insecta <- data.frame(busco, percent)
insecta$database <- "insecta_odb10"
insecta$polishing <- "scaffold"


text2 <- "C:97.6%[S:86.1%,D:11.5%],F:0.4%,M:2.0%,n:954"
percent <- c(86.1,11.5,0.4,2.0)
metazoa <- data.frame(busco, percent)
metazoa$database <- "metazoa_odb10"
metazoa$polishing <- "scaffold"

text3 <- "C:97.1%[S:94.8%,D:2.3%],F:1.2%,M:1.7%,n:1367"
percent <- c(94.8,2.3,1.2,1.7)
old <- data.frame(busco, percent)
old$database <- "insecta_odb10"
old$polishing <- "old"


all <- rbind(insecta, rest, old)

all$busco <- ordered(all$busco, levels =c("missing", "fragmented", "duplicated", "single_copy"))
all$polishing <- ordered(all$polishing, levels =c("raw", "nanopolish", "racon1", "scaffold", "old"))

p1 <- ggplot(all, aes(x = polishing, y = percent, fill = busco))+ geom_bar(stat="identity") + coord_flip()+theme_classic()+scale_fill_manual(values=c("red", "yellow", "dodgerblue", "steelblue2" ))+ labs(y = "%Buscos", x = "", title = "BUSCO Assessment Results")+theme(legend.title=element_blank(), legend.position = "top")+guides(fill=guide_legend(nrow=2,byrow=TRUE)) + theme(text = element_text(size=20))+ theme(text = element_text(size=20))

#ggsave(paste0(figs, "/Busco.pdf"), p1, height = 3, width = 5)

#+annotate("text", x = 1, y = 50, label = text, size = 7)
#+annotate("text", x = 2, y = 50, label = text2, size = 7)



busco_dat <- dat %>%
  mutate(polishing =  as.factor(polishing)) %>%
  mutate(database = as.factor(database)) %>%
  mutate(busco = as.factor(busco)) %>%
  filter(database == "insecta") %>%
  filter(busco != "complete") %>%
  filter(polishing != c("racon2")) %>%
  filter(polishing != c("racon3")) %>%
  filter(polishing != c("racon4")) %>%
  filter(polishing != c("racon5")) %>%
  filter(polishing != c("racon6")) %>%
  filter(polishing != c("racon7")) 

busco_dat$polishing <- droplevels(busco_dat$polishing)
levels(busco_dat$polishing)
busco_dat$polishing <- factor(busco_dat$polishing,levels(busco_dat$polishing)[c(2,1,3)])
levels(busco_dat$polishing)

busco_dat$busco <- droplevels(busco_dat$busco)
levels(busco_dat$busco)
busco_dat$busco <- factor(busco_dat$busco,levels(busco_dat$busco)[c(4,1,2,3)])
levels(busco_dat$busco)

  
ggplot(busco_dat, aes(x = polishing, y = percent, fill = busco))+ geom_bar(stat="identity") + coord_flip()+theme_classic()+scale_fill_manual(values=c("dodgerblue", "steelblue2", "yellow", "red" ))+ labs(y = "%Buscos", x = "", title = "BUSCO Assessment Results")+theme(legend.title=element_blank(), legend.position = "top")+guides(fill=guide_legend(nrow=2,byrow=TRUE)) + theme(text = element_text(size=20)) 

racon_dat <- dat %>%
  filter(database == "insecta") %>%
  mutate(polishing = (str_replace(polishing, "nanopolish", "racon0"))) %>%
  mutate(polishing = (str_replace(polishing, "raw", "racon-1"))) %>%
  filter(grepl("racon", polishing)) %>%
  mutate(iteration = (str_remove(polishing, "racon"))) %>%
  mutate(iteration = as.numeric(iteration))

p2 <- ggplot(racon_dat, aes(x = iteration, y = percent, color = busco))+geom_line(se = FALSE)+geom_point()+facet_wrap(~busco, scales = "free")+theme_classic()
ggsave(paste0(figs, "/polishing_iterations_percent.pdf"), p2, height = 5, width = 10)

p3 <- ggplot(racon_dat, aes(x = iteration, y = n, color = busco))+geom_line()+geom_point()+facet_wrap(~busco, scales = "free")+theme_classic()+labs(x = "Iteration of racon", y = "Number of BUSCOs")
ggsave(paste0(figs, "/polishing_iterations_n.pdf"), p3, height = 5, width = 10)