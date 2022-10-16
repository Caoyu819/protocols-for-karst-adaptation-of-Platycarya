#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("FRGEpistasis")
library(FRGEpistasis)
library(CMplot)
  

setwd("/data/data/Juglandaceae/Platycarya/10_selection/1_getSigGene/25k/130inds")
dat <- read.table("PL_PS_25k.fst.dTD.ROD.dCLR", header = TRUE)

#QQ-normal distribution test
CMplot(dat,plot.type="q",col=c("royalblue", "olivedrab3", "darkgoldenrod1","dodgerblue1"),threshold=1e-6,
       ylab.pos=2,signal.pch=c(19,6,4),signal.cex=1.2,signal.col="red",conf.int=TRUE,box=FALSE,multracks=
         TRUE,cex.axis=2,file="jpg",memo="",dpi=300,file.output=TRUE,verbose=TRUE,ylim=c(0,8),width=5,height=5)

#col=c("dodgerblue1", "olivedrab3", "darkgoldenrod1","darkorchid","coral2","royalblue","hotpink","darkorange")

#inverse-normal-rankBased-transformation of each statistic and calculate p-value
for(i in 4:7){
  dat[,i] <- rankTransPheno(dat[,i],0.5)
}

pdat <- dat
for(i in 4:7){
  pdat[,i] <- pnorm(dat[,i],lower.tail = F)
}

#calculate correlation coefficient between each method's pair
rit <- cor(pdat[,4:7])

#output correalation coefficient between each method's pair
write.table(rit, file = 'correlation_coefficient_4paras.txt',sep="\t",row.names = T,quote = F)

for(i in 1:nrow(pdat)){
  dcms <- 0
  for(j in 4:7){
    dcms <- dcms + log((1-pdat[i,j])/pdat[i,j])/(sum(abs(rit[j-3,]))-1)
  }
  pdat[i,8] <- dcms
}

#inverse-normal-rankBased-transformation of DCMS and calculate p-value
pdat[,8] <- rankTransPheno(pdat[,8],0.5)
pdat[,9] <- pnorm(pdat[,8],lower.tail = F)
names(pdat)[8:9] <- c("DCMS","p_DCMS")

#output pdat of FST,d_TD,ROD
write.table(pdat, file = 'PL_PS_25k.p_fst.p_dTD.p_ROD.p_dCLR.DCMS.p_DCMS',sep="\t",row.names = F,quote = F)

#get regions which p_DCMS <0.05
region <- pdat[pdat$p_DCMS<0.05,]
write.table(region, file = 'signif0.05_DCMS_fst_dTD_ROD_dCLR.txt',sep="\t",row.names = F,quote = F)

#get regions which p_DCMS <0.01
region <- pdat[pdat$p_DCMS<0.01,]
write.table(region, file = 'signif0.01_DCMS_fst_dTD_ROD_dCLR.txt',sep="\t",row.names = F,quote = F)

#get regions which p_DCMS <0.02
region <- pdat[pdat$p_DCMS<0.02,]
write.table(region, file = 'signif0.02_DCMS_fst_dTD_ROD_dCLR.txt',sep="\t",row.names = F,quote = F)
