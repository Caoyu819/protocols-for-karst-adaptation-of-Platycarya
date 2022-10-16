num=$1;  #num of K
#binpath="/home/diyabc/dingym/software/frontend/bin"

data="./3a_indep_25k+25k+0_mask25k.txt"  #input
rdir="result"
logdir="resultlog"

#mkdir -p $rdir   #result dir
#mkdir -p $logdir   #log file dir
for i in {1..20}
{
     random=$(echo $RANDOM)     
     fileout="result_"K$num"_"R$i
     filelog="log"$num"-"$i
     nohup structure -K $1 -D $random -i $data -o ./$rdir/$fileout  >./$logdir/$filelog &
}
