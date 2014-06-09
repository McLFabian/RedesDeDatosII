#rtt medicón promedio
cat file.csv | awk {'print $2'} > rtt.tmp
N=0
rtt_total=0
ant=0
while read line
do
	rtt=0
	let N=N+1
	rtt=$(echo $line" - "$ant|bc)
	#echo "$line - $ant = $rtt \n"
	#rtt_total=$(echo $rtt_total" + "$line|bc)
	rtt_total=$(echo $rtt_total" + "$rtt|bc)
	ant=$line
	read
done < rtt.tmp
rtt_promedio=$(echo $rtt_total" / "$N|bc)
echo "RTT_PROMEDIO " $rtt_promedio >> rtt_promedio.txt > log.txt
rm -rfv rtt.tmp
