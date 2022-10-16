win=$1
inDir=$3
suffix=$4

echo "CHROM	BIN_START	BIN_END	Mean_rho	Median	L95	U95"
for i in `cat $2`
do
	tmp=`echo $i|sed 's/block//g'`
	chr=`echo ${tmp%_*}`
	ed0=`echo ${tmp##*_}`
	ed=$(echo "$ed0*$win"|bc)
	st=$(echo "$ed-$win+1"|bc)
	echo -n "$chr	$st	$ed	"
	if [[ -f $inDir/$i"_"$suffix ]]; then
#	echo "$inDir/$i"_"$suffix"
		sed -n '2p' $inDir/$i"_"$suffix|cut -f2-|sed 's/ //g'
	else
		echo "NULL	NULL      NULL      NULL"
	fi
done
