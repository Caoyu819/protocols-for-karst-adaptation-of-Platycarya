#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("FRGEpistasis")
library(FRGEpistasis)
library("fdrtool")

dat <- read.table("PL_PS_25k.Weighted_Fst",header =TRUE)
dat2 <- read.table("sim_SCS.weighted_Fst", header = TRUE)

#Under neutral population scenerio, we assume that the Fst of simulated data is normal distributed.
#Calculate the mean and standard deviation from the simulated data.
m<-mean(dat2$weighted_Fst)
s<-sd(dat2$weighted_Fst)

#Obtain the p-values for each window's Fst value, based on the normal distribution of simulated data.
pdat <- dat
pdat[,2] <- pnorm(dat[,2],mean = m, sd = s,lower.tail = T)

#Apply the FDR (False Discovery Rate) test to correct the p-values and obtain the q-values (FDR-adjusted values) for each window.
pdat[,3] <- fdrtool(pdat[,2],statistic="pvalue")$pval
pdat[,4] <- fdrtool(pdat[,2],statistic="pvalue")$qval
colnames(pdat)[2] <- 'pvalue_WEIGHTED_FST'
colnames(pdat)[3] <- 'padjust_WEIGHTED_FST'
colnames(pdat)[4] <- 'qvalue_WEIGHTED_FST'

#output pdat of FST
write.table(pdat, file = 'PL_PS_25k.Weighted_Fst_low.Pvalue.padjust.qvalue',sep="\t",row.names = F,quote = F)
