#this script is used for search genes differentially expressed 
#at different treatment times of P. longipes.
#based on R package "ExpHunterSuite":
#https://bioconductor.org/packages/release/workflows/vignettes/ExpHunterSuite/inst/doc/hunter.html#introduction
#"ExpHunterSuite" will call three different ways to do DEG analysis: D:DESeq2 E:EdgeR, L:limma
## ONS<->HCMNS_6h for leaf,root and stem
## ONS<->HCMNS_1d for leaf,root and stem
## ONS<->HCMNS_7d for leaf,root and stem

library(ExpHunterSuite)

setwd("/Volumes/result/14_DiffExpressGene_Analy/trscrptData_labExperiment/2_deseq")

#1. Basic Differential Expression Analysis

#1.1 deg with different treatment for PL and PS, separately;
## prepare the toc(matrix of expression level) and target(imap list of control and treatment)
dir.create("1_PL")
matrix_pl <- read.table("gem_salmon_72samples.rawCounts.PL.txt", header = T,row.names = 1)

treat <- c("6h","1d","7d")
tissues <- c("LEAF","ROOT","STEM")

for (i in 1:3){
  #define the target for each comparision
  i <-3
  target <- read.table(paste0("imap_36samples_PL.ctrl-",treat[i]), header = T)
  
  for (j in 1:3){
    j <-3
    #create outpu directory
    outdir <- paste0("1_PL/pl_ctrl-",treat[i],"_",tissues[j])
    dir.create(outdir)
    #do deg analysis using function "main_degenes_Hunter" of R package "ExpHunterSuite"
    degh_out <- main_degenes_Hunter(raw=matrix_pl,
                                       target=target[target$tissue==tissues[j],],
                                       modules="D") ## D:DESeq2 E:EdgeR, L:limma
    #output the matrices of deg
    write.table(degh_out$DE_all_genes,paste0(outdir,"/degh_out_pl_",treat[i],"_",tissues[j],".txt"),sep = "\t")
    #write the report to outputDir
    write_expression_report(exp_results=degh_out,output_files=outdir)
  }
}

#2. Co-expression Analysis
## fail to run it through!!! try to figure out:)
matrix_coexp <- read.table("gem_salmon_72samples.rawCounts.txt", header = T,row.names = 1)
imap_coexp <-read.table("imap_72samples_coexpression", header = T)

degh_out_coexp <- main_degenes_Hunter(raw=matrix_coexp, 
                                      target=imap_coexp, 
                                      modules="DW", 
                                      model_variables="tissue", 
                                      string_factors="time")

#3. output report
print(getwd())
write_expression_report(exp_results=degh_out_pl_6h,output_files="pl_ctrl-6h")
write_expression_report(exp_results=degh_out_pl_1d,output_files="pl_ctrl-1d")
write_expression_report(exp_results=degh_out_pl_7d,output_files="pl_ctrl-7d")

write_expression_report(exp_results=degh_out_ps_6h,output_files="ps_ctrl-6h")
write_expression_report(exp_results=degh_out_ps_1d,output_files="ps_ctrl-1d")
write_expression_report(exp_results=degh_out_ps_7d,output_files="ps_ctrl-7d")

write_expression_report(exp_results=degh_out_coexp,output_files="pl-ps_coexp")
