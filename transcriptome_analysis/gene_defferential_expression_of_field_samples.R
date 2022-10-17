#==============read.file====================================##
tl <- read.table("tl.matrix", header = T)
tl.list <- strsplit(colnames(tl), split = ".", fixed = T)
tl.id <- unlist(lapply(tl.list, function(x){x[1]}))
colnames(tl) <- tl.id
rm(tl.list)
tl.pl <- tl[,1:26]
tl.ps <- tl[,27:42]
#==============correlation.heatmap==========================##
wm.pl.cor <- cor(wm.pl)
wm.ps.cor <- cor(wm.ps)
dist.wm.pl <- dist(t(wm.pl), method = "manhattan")
dist.wm.ps <- dist(t(wm.ps), method = "manhattan")
pheatmap(as.matrix(dist.wm.ps), cellheight = 10, cellwidth = 10)
pheatmap(wm.pl.cor, cellheight = 20, cellwidth = 20, display_numbers = T)
pheatmap(as.matrix(dist.wm.ps), cellheight = 10, cellwidth = 10)
pheatmap(wm.ps.cor, cellheight = 20, cellwidth = 20, display_numbers = T)

#==============deg.analysis==================================##
condition <- factor(c(rep("pl",3), rep("ps",3)))
tl.leaf <- subset(tl, select = c(PL_TL_L5,PL_TL_L11,PL_TL_L13,PS_TL_L1,PS_TL_L2,PS_TL_L7))  ##substitute the id name here manually
tl.leaf <- round(tl.leaf)
colData.tl.leaf <- data.frame(row.names=colnames(tl.leaf), condition)
library(DESeq2)
dds.tl.leaf <- DESeqDataSetFromMatrix(tl.leaf, colData.tl.leaf, design= ~ condition )
dds.tl.leaf <- DESeq(dds.tl.leaf)
res.tl.leaf <- results(dds.tl.leaf)
#=====================extract.sig.gene=======================##
sig.tl.leaf <- res.tl.leaf[order(res.tl.leaf$padj),]
diffgene.tl.leaf <-subset(sig.tl.leaf,padj < 0.05 & (log2FoldChange > 1 | log2FoldChange < -1))
resdata.tl.leaf <-  merge(as.data.frame(diffgene.tl.leaf),as.data.frame(counts(dds.tl.leaf,normalize=TRUE)),by="row.names",sort=FALSE)
#output the results
write.table(res.tl.leaf, file = "tl.allres.txt", quote = F, row.names = T, col.names = T, sep = "\t")
#output the genes that are differentially expressed
write.table(resdata.tl.leaf, file = "11111.txt", quote = F, row.names = T, col.names = T, sep = "\t")

##plot heatmap of correlation of samples
pheatmap(cor.test, 
         cellheight = 20, 
         cellwidth = 20, 
         fontsize_number = 8,
         breaks = bk,
         display_numbers = T,
         cluster_cols=T,
         cluster_rows=T,
         color = colorRampPalette(rev(brewer.pal(n = 7, name ="RdYlBu")))(101),
         file = "./leaf.pdf",
         width = 8,
         height = 8)
bk <- seq(0,1,by = 0.01)

