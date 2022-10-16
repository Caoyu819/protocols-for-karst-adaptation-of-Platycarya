setwd ("/data/data/Juglandaceae/Platycarya/10_selection/1_getSigGene/25k")
library(ggpubr)

#df=diamonds[sample(1:dim(diamonds)[1],40),]
#df$price=df$price / 10000

dat <- read.table("PL-PS.Varmt10.25k.fst.dTD.dPI.inputDCMS.roh",header = TRUE) #data used to calculate correlation bettween roh and (fst,d_TD,d_PI)
dat <- read.table("signif0.05_PL_DCMS_ThreeParas.pi.fst.ROD.dxy.TajimaD.CLR.roh", header = TRUE) #data used to calculate correlation bettween roh and (fst,d_TD,d_PI), select from significant result
dat <- read.table("PL_DCMS_FourParas_fst_dTD_dPI_rohden.txt",header = TRUE) #data used to calculate correlation bettween roh and -log10(p_DCMS)


p=dat%>%ggplot(aes(dat$roh_PL,dat$MEAN_FST_PL.PS))+
#p=dat%>%ggplot(aes(dat$MEAN_FST_PL.PS,dat$ROD_PS.PL))+
  geom_point(size=1,alpha=0.3,color="#6baed6")+
  geom_smooth(method = "lm", formula = y~x, color = "#756bb1", fill = "#cbc9e2")+ #颜色选自https://colorbrewer2.org/
  theme_bw()+
  labs(x = "ROH length (*10e5 bp)",y="FST")+
#  labs(x = "FST",y="ROD(pi_PS/pi_PL)")+
  theme(
    panel.grid.major = element_blank(),panel.grid.minor = element_blank()
  ) +
  theme(title= element_text(size=15, color="black", face= "bold", vjust=0.5, hjust=0.5))+
  theme(panel.border = element_rect(color = "grey",size = 1.5,fill=NA),
        panel.grid = element_blank(),panel.background = element_rect(fill = 'transparent'))

p
p+stat_cor()

ggsave("correlation_scatter_plot_roh_fst.pdf",width = 9,height = 9,units = "cm")
