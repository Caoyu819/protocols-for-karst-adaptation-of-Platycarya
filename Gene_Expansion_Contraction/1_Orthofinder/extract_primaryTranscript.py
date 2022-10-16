#!/usr/bin/env python3
#-*- coding:utf-8 -*-

from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
import gffutils
import re
import sys,os

#######################

#从cds获得每条转录本的长度，从gff获得每个基因包含哪些转录本

cds = sys.argv[1]
gff = sys.argv[2]
fout = sys.argv[3]

#seq_index_ps = SeqIO.index(cds ,'fasta')
#gffdb_ps = gffutils.create_db(gff,dbfn='gff.db',force=True,merge_strategy='creat_unique')

seq_index = SeqIO.index(cds ,'fasta')
gffdb = gffutils.create_db(gff,dbfn='gff.db',force=True,merge_strategy='replace')
#以基因为key，转录本为value的字典
gene2longestcds = {}

#对基因进行迭代
for g in gffdb.all_features(featuretype='gene'):
    g_id= g.id
    for m in gffdb.children(g, featuretype='mRNA'):##只关注mRNA信息
        #m_id = m.id.replace('rna-' , '')
        m_id = m.id
        m_len = len(seq_index[m_id].seq)
        #一个基因中最长转录本的名字
        if g_id not in gene2longestcds:
            gene2longestcds[g_id] = m_id
        elif m_len >len(seq_index[gene2longestcds[g_id]].seq):
            gene2longestcds[g_id] = m_id

sr_list = [v for k,v in seq_index.items() if k in gene2longestcds.values()]

##输出
SeqIO.write(sr_list, fout, 'fasta')
