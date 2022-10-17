#Author: Jun Chen (Beijing Normal University)
#Date: 09-03-2021

from contextlib import ExitStack
from itertools import zip_longest
import os
def handle(i,num,lines_data,names_list):
    n_l = ['']*len(names_list)
    for v_num in range(len(lines_data[0])):
        num+=1
        if 'N' in set([x[v_num] for x in lines_data]):
            if len(n_l[0]) >=300:
                file_need = open(wk_dir+'loci'+str(i)+'.fasta','w')
                i += 1
                file_need.write(str(len(names_list))+' '+str(len(n_l[0])) +'begin_at:'+str(num) +' '+'\n')
                for index,value in enumerate(names_list):
                    file_need.write(value+n_l[index]+'\n')
                file_need.close()
                break
            else:
                pass
            n_l = ['']*len(names_list)
        elif len(n_l[0])>=1000:
            file_need = open(wk_dir+'loci'+str(i)+'.fasta','w')
            i += 1
            file_need.write(str(len(names_list))+' '+str(len(n_l[0])) +'begin_at:'+str(num) +' '+'\n')
            for index,value in enumerate(names_list):
                file_need.write(value+n_l[index]+'\n')
            file_need.close()
            break
        else:
            for n_v,v_v in enumerate([x[v_num] for x in lines_data]):
                n_l[n_v] = n_l[n_v] + v_v
    return i,num




wk_dir = './'
file_list = os.listdir(wk_dir)
flist = []
for file_name in file_list:
    if file_name.endswith('.fasta'):
        flist.append(file_name)

with ExitStack() as stack:
    files = [stack.enter_context(open(wk_dir+fname)) for fname in flist]
    names_list = ['>'+fname.strip('.maskDEP.maskCDS.fasta')+'\n' for fname in flist]
    i = 0
    for lines in zip_longest(*files):
        if all([x.startswith('>PstrChr') for x in lines]):
            pass
        elif lines[0].startswith('>PstrContig'):
            break
        else:
            lines = [x.strip('/n') for x in lines]
            num = 24999
            while True:
                if num <len(lines[0]):
                    i,num = handle(i,num,[x[num:] for x in lines],names_list)
                    num += 25000
                    print(i,num)
                else:
                    break
