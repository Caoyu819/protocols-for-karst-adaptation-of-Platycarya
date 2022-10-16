rm(list=ls())
arg <- commandArgs(T)
#usage: Rscript vcf2block.R <snpDen.file> <ctglist> <inputDir/> <windowSize> <sampleSize of pop> <outputDir>

list <- read.table(arg[1],header = T,stringsAsFactors = F) #input file1:snpDensity
ctglist <- read.table(arg[2],sep = "\n",stringsAsFactors = F) #input file4:ctglist
for(i in 1:length(ctglist[,1])){
  chrname <- ctglist[i,1]
  listsub <- list[list$CHROM==chrname,]
  sitefile <- read.table(paste(arg[3],chrname,".ldhat.sites",sep=""),sep = "\n",stringsAsFactors = F) #arg[3]: inputdir: input file2
  locsfile <- read.table(paste(arg[3],chrname,".ldhat.locs",sep=""),sep = "\n",stringsAsFactors = F) #arg[3]: inputdir: input file3
  pos <- 1
  for(j in 1:nrow(listsub)){
    if(listsub[j,3]==1){
      print(paste(chrname,"-block",listsub[j,3]/as.numeric(arg[4])+1,sep="")) #arg[4]: windowsize
      pos=pos+1
      next}

#Jmad#
#    jmaddata <- data.frame(seq="a",stringsAsFactors = F)
#    jmaddata[1,1] <- paste(20,listsub[j,4],2,sep="\t") #20 means ind number, listsub{j,4} means snp, 2 means type
#    for(m in 1:20){ 
#      jmaddata[m*2,1] <- sitefile[(m*2),1]
#      jmaddata[(m*2+1),1] <- substr(sitefile[m*2+1,1],pos,(pos+listsub[j,4]-1))
#    }
    
    
#    jredata <- data.frame(seq="a",stringsAsFactors = F)
#    jredata[1,1] <- paste(31,listsub[j,4],2,sep="\t")
#    for(m in 1:31){
#      jredata[(m)*2,1] <- sitefile[(m*2),1]
#      jredata[((m)*2+1),1] <- substr(sitefile[m*2+1,1],pos,(pos+listsub[j,4]-1))
#    }


#    jhopdata <- data.frame(seq="a",stringsAsFactors = F)
#    jhopdata[1,1] <- paste(49,listsub[j,4],2,sep="\t")
#    for(m in 1:49){
#      jhopdata[(m)*2,1] <- sitefile[(m*2),1]
#      jhopdata[((m)*2+1),1] <- substr(sitefile[m*2+1,1],pos,(pos+listsub[j,4]-1))
#    }
  
   
    jcatdata <- data.frame(seq="a",stringsAsFactors = F) 
    jcatdata[1,1] <- paste(arg[5],listsub[j,3],2,sep="\t") #arg[5]: is sample number, should replace to your sample size, the same blow
    for(m in 1:arg[5]){
      jcatdata[(m)*2,1] <- sitefile[(m*2),1]
      jcatdata[((m)*2+1),1] <- substr(sitefile[m*2+1,1],pos,(pos+listsub[j,3]-1))
    }


    locsdata <- data.frame(seq="a",stringsAsFactors = F)
    locsdata[1,1] <- paste(listsub[j,3],(listsub[j,2]+as.numeric(arg[4]))/1000,"L",sep="\t") #/1000 means pos
    locsdata[2:(listsub[j,3]+1),1] <- locsfile[(pos+1):(pos+listsub[j,3]),1] #for 3 line file; if for 1 line, change pos+1, +2 delete
    pos <- pos+listsub[j,3]
#    write.table(jmaddata,paste(chrname,"_block",listsub[j,3]/50000,"_Jmad",".sites",sep=""),col.names = F,row.names = F,quote = F)
#    write.table(jredata,paste(chrname,"_block",listsub[j,3]/25000,"_Jre",".sites",sep=""),col.names = F,row.names = F,quote = F)
#    write.table(jhopdata,paste(chrname,"_block",listsub[j,3]/50000,"_Jhop",".sites",sep=""),col.names = F,row.names = F,quote = F) #windows change
    write.table(jcatdata,paste(arg[6],chrname,"_block",listsub[j,2]/as.numeric(arg[4])+1,".sites",sep=""),col.names = F,row.names = F,quote = F) #arg[6]: outputDir; arg[4]: windows change
    write.table(locsdata,paste(arg[6],chrname,"_block",listsub[j,2]/as.numeric(arg[4])+1,".locs",sep=""),col.names = F,row.names = F,quote = F) #arg[6]: outputDir; arg[4]: windows change
#    print(paste(chrname,"-block",listsub[j,3]/25000,sep=""))
  }
  print(i)
}
