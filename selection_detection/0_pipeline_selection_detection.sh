#0. pre input for DCMS
perl pre_inputDCMS.pl PL_PS_25k.fst.TD.pi PL_PS_25k.fst.dTD.ROD

#1. cal DCMS and get signif_DCMS
run DCMS.R in the Rstudio

#2. plot manhattan of p_FST,p_dTD,p_ROD,p_DCMS
run CMplot.R in the Rstudio

#3. display correaltion between different parameters
run corr_scatter_plot.R in the Rstudio

#4. get significant block
#by DCMS
cut -f1 signif0.05_DCMS_fst_dTD_ROD_dCLR.txt |awk -F "_" '{print $1"\t"$2"\t"$3}' >signif0.05_DCMS_fst_dTD_ROD_dCLR.block

#5. get gene belong to block
perl ../../scripts_Sel_signal/2_get_gene_belong_to_blocks.pl signif0.05_DCMS_fst_dTD_ROD_dCLR.block ../../../4_syri/Pstr_v3.gene.gff3 signif0.05_DCMS_fst_dTD_ROD_dCLR.block.gene.all
cut -f1,5 signif0.05_DCMS_fst_dTD_ROD_dCLR.block.gene.all|sed 's/ID=//g'|cut -d";" -f1|sort -k2 |uniq >signif0.05_DCMS_fst_dTD_ROD_dCLR.block.gene
cut -f5 signif0.05_DCMS_fst_dTD_ROD_dCLR.block.gene.all|cut -d";" -f1|sed 's/ID=//g;s/cds.//g'|cut -d"." -f1|sort |uniq >signif0.05_DCMS_fst_dTD_ROD_dCLR.block.gene.name
