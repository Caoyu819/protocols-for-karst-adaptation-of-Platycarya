#!/usr/bin/env python3
#-*- coding:utf-8 -*-

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import gffutils
import re
import sys,os

#######################

#Retrieve the length of each transcript and obtain the information for the transcripts of each gene from the GFF file.
cds = sys.argv[1]
gff = sys.argv[2]
fout = sys.argv[3]

#seq_index_ps = SeqIO.index(cds ,'fasta')
#gffdb_ps = gffutils.create_db(gff,dbfn='gff.db',force=True,merge_strategy='creat_unique')

seq_index = SeqIO.index(cds ,'fasta')
gffdb = gffutils.create_db(gff,dbfn='gff.db',force=True,merge_strategy='replace')
#Creat the dictionary: key='gene', value='transcript'
gene2longestcds = {}

#Iterate over each gene.
for g in gffdb.all_features(featuretype='gene'):
    g_id= g.id
    #Only extract the information of mRNA
    for m in gffdb.children(g, featuretype='mRNA'):
        m_id = m.id
        #Check if the gene/mRNA name in the GFF file also appears in the input CDS/PEP FASTA file.
        if m_id not in seq_id:
            #print (f"{m_id} is not in fasta file")
            continue
        else:
        #m_id = m.id.replace('rna-' , '')
            m_len = len(seq_index[m_id].seq)
        #the name of longest transcript
            if g_id not in gene2longestcds:
                gene2longestcds[g_id] = m_id
            elif m_len >len(seq_index[gene2longestcds[g_id]].seq):
                gene2longestcds[g_id] = m_id
                
sr_list = [v for k,v in seq_index.items() if k in gene2longestcds.values()]

#Output the longest transcript to file
SeqIO.write(sr_list, fout, 'fasta')
