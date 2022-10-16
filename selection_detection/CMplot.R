library(CMplot)
setwd("/data/data/Juglandaceae/Platycarya/10_selection/1_getSigGene/25k/130inds")

#sink("0_threshold.summary.txt",append=FALSE,split=TRUE)

dat <- read.table("PL_PS_25k.p_fst.p_dTD.p_ROD.p_dCLR.p_DCMS.chr", header = TRUE)

#p_DCMS
CMplot(dat[c(1:3,8)],plot.type="m", ylab = "-log10(p_DCMS)",
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), threshold.col=c('red','orange'), signal.col = c('red','orange'),
       chr.den.col=NULL,
       multracks=FALSE,
       amplify=TRUE,
       signal.cex=c(1,1),signal.pch=c(19,19),
       file="jpg",memo="p_DCMS_1022",
       dpi=300,file.output=TRUE,verbose=TRUE)

CMplot(dat[c(1:3,8)],plot.type="m", 
       col=c("gray60","LightSkyBlue"), #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       multracks=FALSE, 
       cex=0.5,
       threshold=c(0.01),threshold.lty=c(2,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c("grey","coral2"), 
       signal.col=c("red","orange"),
       signal.cex=c(0.5,0.5),
       highlight = c("03_48125001_48150000", "03_48125001_48150000", "07_750001_775000", "06_2800001_2825000", "14_10450001_10475000", "13_36775001_36800000", "05_48200001_48225000", "05_48200001_48225000", "07_2850001_2875000", "07_2850001_2875000", "12_575001_600000", "05_2400001_2425000", "04_5400001_5425000", "03_52375001_52400000"),
       highlight.text=c("PstrChr03G001833", "PstrChr03G001837", "PstrChr07G000026", "PstrChr06G000128", "PstrChr14G000562", "PstrChr13G001413", "PstrChr05G002129", "PstrChr05G002130", "PstrChr07G000173", "PstrChr07G000176", "PstrChr12G000038", "PstrChr05G000207", "PstrChr04G000302", "PstrChr03G002209"),
       highlight.col = 'black',
#       highlight.text.xadj=c(0,0,0,0,0,0,0,0,0,0,0,0,0,0),
       highlight.cex = 0.5,
       highlight.text.cex = 1,
       #outward=TRUE,
       file="jpg",
       memo="p_DCMS_4Stats_14genes_from52genes_1112",dpi=300,file.output=TRUE,verbose=TRUE)

CMplot(dat[c(1:3,8)],plot.type="m", 
       col=c("gray60","LightSkyBlue"), #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       multracks=FALSE, 
       cex=0.5,
       threshold=c(0.01,0.02),threshold.lty=c(2,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c( "grey","coral2"), 
       signal.col=c("red","orange"),
       signal.cex=c(0.5,0.5),
       highlight = c("02_35350001_35375000", "03_5575001_5600000", "03_5575001_5600000", "05_1_25000", "05_2400001_2425000", "06_20600001_20625000", "06_24950001_24975000", "06_2800001_2825000", "07_2850001_2875000", "10_17000001_17025000", "10_5200001_5225000", "11_5775001_5800000", "12_10550001_10575000", "13_33825001_33850000", "13_36775001_36800000"),
       highlight.text=c("At2g13820", "CIPK24", "LRR_6", "FRO7", "MRS2-3", "pKIWI502", "MIZ1", "RhGT1", "REV3", "CML49", "3GGT", "CML25", "PYR1", "NAHEXCHNGR3", "UNE10"),
       highlight.col = 'black',
#       highlight.text.xadj=c(0,0,0,0,0),
#       highlight.text.yadj=c(1,1,1,1,1),
       highlight.cex = 0.5,
       highlight.text.cex = 1,
       #outward=TRUE,
       file="pdf",
       memo="p_DCMS_4Stats_15genesMarked_from68genes_1120",dpi=300,file.output=TRUE,verbose=TRUE)

CMplot(dat[c(1:3,8)],plot.type="m", 
       col=c("gray60","LightSkyBlue"), #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       multracks=FALSE, 
       cex=0.5,
       threshold=c(0.01,0.02),threshold.lty=c(2,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c( "grey","coral2"), 
       signal.col=c("red","orange"),
       signal.cex=c(0.5,0.5),
       highlight = c("05_1_25000", "05_2400001_2425000", "06_24950001_24975000", "10_17000001_17025000", "10_5200001_5225000", "11_5775001_5800000", "13_33825001_33850000"),
       highlight.text=c("FRO7", "MRS2-3", "MIZ1", "CML49", "3GGT", "CML25", "NAHEXCHNGR3"),
       highlight.col = 'black',
       #       highlight.text.xadj=c(0,0,0,0,0),
       #       highlight.text.yadj=c(1,1,1,1,1),
       highlight.cex = 0.5,
       highlight.text.cex = 1,
       #outward=TRUE,
       file="jpg",
       memo="p_DCMS_4Stats_7genesMarked_from68genes_1120",dpi=300,file.output=TRUE,verbose=TRUE)


#p_CLR_vocalnoFinder

dat <- read.table("PL_25k.signif0.01.vocalno.p_CLR.chr", header = TRUE)
CMplot(dat[c(1:3,4)],plot.type="m", 
       col=c("dodgerblue4","LightSkyBlue"),multracks=FALSE, #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       threshold=c(0.01,0.02),threshold.lty=c(1,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c("lightskyblue","deepskyblue"), 
       signal.col=c("red","orange"),signal.cex=c(1,1),
       #outward=TRUE,
       file="jpg",
       memo="p_CLR_vocalno_1112",dpi=300,file.output=TRUE,verbose=TRUE)

#p_FST
CMplot(dat[c(1:3,4)],plot.type="m", ylab = "-log10(p_FST)",
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), threshold.col=c('red','orange'), signal.col = c('red','orange'),
       chr.den.col=NULL,
       multracks=FALSE,
       amplify=TRUE,
       signal.cex=c(1,1),signal.pch=c(19,19),
       file="jpg",memo="p_FST_0923",
       dpi=300,file.output=TRUE,verbose=TRUE)
#p_dTD
CMplot(dat[c(1:3,5)],plot.type="m", ylab = "-log10(p_delta_Tajima's D)",
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), threshold.col=c('red','orange'), signal.col = c('red','orange'),
       chr.den.col=NULL,
       multracks=FALSE,
       amplify=TRUE,
       signal.cex=c(1,1),signal.pch=c(19,19),
       file="jpg",memo="p_dTD_0923",
       dpi=300,file.output=TRUE,verbose=TRUE)
#p_ROD
CMplot(dat[c(1:3,6)],plot.type="m", ylab = "-log10(p_ROD(PI_PS/PI_PL))",
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), threshold.col=c('red','orange'), signal.col = c('red','orange'),
       chr.den.col=NULL,
       multracks=FALSE,
       amplify=TRUE,
       signal.cex=c(1,1),signal.pch=c(19,19),
       file="jpg",memo="p_ROD_0923",
       dpi=300,file.output=TRUE,verbose=TRUE)
#p_CLR
CMplot(dat[c(1:3,7)],plot.type="m", ylab = "-log10(p_ROD(CLR_PL-CLR_PS))",
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), threshold.col=c('red','orange'), signal.col = c('red','orange'),
       chr.den.col=NULL,
       multracks=FALSE,
       amplify=TRUE,
       signal.cex=c(1,1),signal.pch=c(19,19),
       file="jpg",memo="p_CLR_1022",
       dpi=300,file.output=TRUE,verbose=TRUE)


#signif : all characters
CMplot(dat,plot.type="m",ylab = "-log10(p)",
       col=c("gray60","LightSkyBlue"),
       LOG10=TRUE, cex = c(0.5,0.5),
       threshold=c(0.01,0.02), 
       threshold.col=c('red','orange'), 
       multracks=TRUE,
       amplify=TRUE,bin.size=1e6,chr.den.col=c( "grey","coral2"), 
       signal.col=c("red","orange"),
       signal.cex=c(0.5,0.5),
       highlight = c("05_1_25000", "05_2400001_2425000", "06_24950001_24975000", "10_17000001_17025000", "10_5200001_5225000", "11_5775001_5800000", "13_33825001_33850000"),
       highlight.text=c("FRO7", "MRS2-3", "MIZ1", "CML49", "3GGT", "CML25", "NAHEXCHNGR3"),
       highlight.col = 'black',
       highlight.cex = 0.5,
       highlight.text.cex = 1,
       file="jpg",memo="all_1122_withcolor",
       dpi=300,height=5, width=20,
       file.output=TRUE,verbose=TRUE)
CMplot(dat[c(1:3,8)],plot.type="m", 
       col=c("gray60","LightSkyBlue"), #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       multracks=FALSE, 
       cex=0.5,
       threshold=c(0.01,0.02),threshold.lty=c(2,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c( "grey","coral2"), 
       signal.col=c("red","orange"),
       signal.cex=c(0.5,0.5),
       highlight = c("05_1_25000", "05_2400001_2425000", "06_24950001_24975000", "10_17000001_17025000", "10_5200001_5225000", "11_5775001_5800000", "13_33825001_33850000"),
       highlight.text=c("FRO7", "MRS2-3", "MIZ1", "CML49", "3GGT", "CML25", "NAHEXCHNGR3"),
       highlight.col = 'black',
       #       highlight.text.xadj=c(0,0,0,0,0),
       #       highlight.text.yadj=c(1,1,1,1,1),
       highlight.cex = 0.5,
       highlight.text.cex = 1,
       #outward=TRUE,
       file="jpg",
       memo="p_DCMS_4Stats_7genesMarked_from68genes_1120",dpi=300,file.output=TRUE,verbose=TRUE)


#xull
CMplot(dat[c(1:3,7,10,8)], plot.type = "c",
#CMplot(dat[sample(1:nrow(data), 10000),c(1:3,5)], plot.type = "c",
       chr.labels = c(1:15),
       r = 5,
       cir.legend = TRUE,
       LOG10 = FALSE,
       #outward = FALSE,
       cex = 0.5,
       band = 0.5,
       cir.legend.col = "black",
       cir.chr.h = 1.3,
       cir.band = 0.2,
       chr.den.col = "black",
       file = "jpg",
       memo = "0405",
       dpi = 300,
       file.output = TRUE,
       verbose = TRUE)

#example
CMplot(pig60K[sample(1:nrow(pig60K),10000),c(1:4)],plot.type="m", 
       col=c("dodgerblue4","LightSkyBlue"),multracks=FALSE, #col=matrix(c("grey30","grey60",NA,"red","blue","green","orange",NA,NA),3,3,byrow=T)
       threshold=c(1e-6,1e-4),threshold.lty=c(1,2), 
       threshold.lwd=c(1,1), threshold.col=c("black","grey"), 
       amplify=TRUE,bin.size=1e6,chr.den.col=c("red", "green","darkgreen"), 
       signal.col=c("red","orange"),signal.cex=c(1,1),
       #outward=TRUE,
       file="pdf",
       memo="",dpi=300,file.output=TRUE,verbose=TRUE)
CMplot(pig60K[,1:4], plot.type="m", LOG10=TRUE, ylim=NULL, threshold=c(1e-6,1e-4),
       threshold.lty=c(1,2),threshold.lwd=c(1,1), 
       threshold.col=c("black","grey"), amplify=F,
       bin.size=1e6,chr.den.col=c("darkgreen", "yellow","red"),
       signal.col=c("red","green"),signal.cex=c(1,1),
       signal.pch=c(19,19),
       highlight = c('ALGA0000009','ALGA0000022'),highlight.col = 'red',
       highlight.cex = 1,highlight.text=c('1','2'),
       file="pdf",memo="",dpi=300,
       file.output=TRUE,verbose=TRUE)
#threshold设置阈值，如4和6(log以后的)
#signal设置超过阈值的点，如绿色和红色的点
#highlight个性化某些点，如图中的两个黑色的点
#highlight.text为某些点添加标签

##"dodgerblue1", "olivedrab3", "darkgoldenrod1","darkorchid","coral2","royalblue","hotpink","darkorange"
