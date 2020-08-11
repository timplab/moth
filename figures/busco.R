library(ggplot2)

# data from BUSCO output C:97.6%[S:97.4%,D:0.2%],F:0.5%,M:1.9%,n:1658

names <- c("Complete BUSCOs (C)", "Complete and single-copy BUSCOs (S)", "Complete and duplicated BUSCOs (D)", "Fragmented BUSCOs (F)", "Missing BUSCOs (M)")

nums <- as.numeric(c(1619,1615,4, 8, 31))

percents <- c(97.6, 97.4,0.2,0.5,1.9)
dat <- data.frame(names, nums, percents)


bp <- ggplot(dat, aes(x="", y=nums, fill=names))+
  geom_bar(width = 1, stat = "identity")

pie <- bp + coord_polar("y", start=0)

blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

pie + scale_fill_brewer(palette = "Dark2") + blank_theme +
  theme(axis.text.x=element_blank())

            