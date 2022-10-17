#0. prepare the inputfile of cafe
awk 'OFS="\t" {$NF="" ;print $0}' Orthogroups.GeneCount.tsv > cafe.data.1
sed 's/^/null\t&/g' cafe.data.1 >cafe.data
#modify title of cafe.data:Desc	Family ID	Cil	Mru	Plon	Pstr	Rch
python cafetutorial_clade_and_size_filter.py -i cafe.data -o cafe.filter.data -s
##. modify cafetutorial_run.sh

#1.run cafe by shell script
nohup cafe cafetutorial_run.sh &
nohup cafe cafetutorial_run_filter.sh &
#2. summarize the result of cafe
#output the rapidly changing families on each nodes
python2 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_report_analysis.py -i resultfile.cafe -o summary_cafe_rapidChange >log_summary_cafe_rapidChange &
python2 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_report_analysis.py -i resultfile.largefilter.cafe -o summary_cafe_largefilter_rapidChange >log_summary_cafe_largefilter_rapidChange &
#ouput all changing families on each nodes
python2 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_report_analysis.py -i resultfile.cafe -o summary_cafe_allChange -r 0 >log_summary_cafe_allChange &
python2 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_report_analysis.py -i resultfile.largefilter.cafe -o summary_cafe_largefilter_allChange >log_summary_cafe_largefilter_allChange &

#3.1 visualize through cafe home script
python3.6 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_draw_tree.py -i summary_cafe_rapidChange_node.txt -t '((((Plon:2,Pstr:2):62,Cil:64):23,Rch:87):10,Odav:97)' -d '((((Plon<0>,Pstr<2>)<1>,Cil<4>)<3>,Rch<6>)<5>,Odav<8>)<7>' -o summary_cafe_rapidChange_node_expand.png
python3.6 /data/data/Juglandaceae/Platycarya/13_geneExCon/python_scripts/cafetutorial_draw_tree.py -i summary_cafe_rapidChange_node.txt -t '((((Plon:2,Pstr:2):62,Cil:64):23,Rch:87):10,Odav:97)' -d '((((Plon<0>,Pstr<2>)<1>,Cil<4>)<3>,Rch<6>)<5>,Odav<8>)<7>' -y Contractions -o summary_cafe_rapidChange_node_contract.png

#3.2 visualize through cafe_fig
python3.6 ~/software/CAFE_fig-master/CAFE_fig.py resultfile.cafe -pb 0.01 -pf 0.01 --dump test/ -g pdf --count_all_expansions

#4. get orthologues from output of cafe
#rapidly changing OGs' list
sed -n '7p' summary_cafe_rapidChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "+"|cut -c1-9 >signif_expandOG_inPS.list
sed -n '6p' summary_cafe_rapidChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "+"|cut -c1-9 >signif_expandOG_inPL.list
sed -n '7p' summary_cafe_rapidChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "-"|cut -c1-9 >signif_contractOG_inPS.list
sed -n '6p' summary_cafe_rapidChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "-"|cut -c1-9 >signif_contractOG_inPL.list

#all changing OGs' list
sed -n '7p' summary_cafe_allChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "+"|cut -c1-9 >all_expandOG_inPS.list
sed -n '6p' summary_cafe_allChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "+"|cut -c1-9 >all_expandOG_inPL.list
sed -n '7p' summary_cafe_allChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "-"|cut -c1-9 >all_contractOG_inPS.list
sed -n '6p' summary_cafe_allChange_fams.txt |sed 's/,/\n/g;s/:/\n/g;s/\t//g'|grep "-"|cut -c1-9 >all_contractOG_inPL.list

#reform the OG-gene pair file
python split_with_one_gene.py Orthogroups.txt Orthogroups_genes.txt

#get genelist of changing OGs
grep -f signif_expandOG_inPS.list Orthogroups_genes.txt|grep "Pstr" >signif_expandOG_inPS.OGs.genes
grep -f signif_expandOG_inPL.list Orthogroups_genes.txt|grep "Plon" >signif_expandOG_inPL.OGs.genes
grep -f signif_contractOG_inPS.list Orthogroups_genes.txt|grep "Pstr" >signif_contractOG_inPS.OGs.genes
grep -f signif_contractOG_inPL.list Orthogroups_genes.txt|grep "Plon" >signif_contractOG_inPL.OGs.genes

cut -f2 signif_contractOG_inPL.OGs.genes >signif_contractOG_inPL.genes
cut -f2 signif_contractOG_inPS.OGs.genes >signif_contractOG_inPS.genes
cut -f2 signif_expandOG_inPL.OGs.genes >signif_expandOG_inPL.genes
cut -f2 signif_expandOG_inPS.OGs.genes >signif_expandOG_inPS.genes

grep -f all_expandOG_inPS.list Orthogroups_genes.txt|grep "Pstr" >all_expandOG_inPS.OGs.genes
grep -f all_expandOG_inPL.list Orthogroups_genes.txt|grep "Plon" >all_expandOG_inPL.OGs.genes
grep -f all_contractOG_inPS.list Orthogroups_genes.txt|grep "Pstr" >all_contractOG_inPS.OGs.genes
grep -f all_contractOG_inPL.list Orthogroups_genes.txt|grep "Plon" >all_contractOG_inPL.OGs.genes

cut -f2 all_contractOG_inPL.OGs.genes >all_contractOG_inPL.genes
cut -f2 all_contractOG_inPS.OGs.genes >all_contractOG_inPS.genes
cut -f2 all_expandOG_inPL.OGs.genes >all_expandOG_inPL.genes
cut -f2 all_expandOG_inPS.OGs.genes >all_expandOG_inPS.genes
