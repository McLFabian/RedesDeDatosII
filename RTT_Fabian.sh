#RTT: Medición promedio
cat Frame-RelativeTime.log | awk -F'	' '{print $4}' > rtt.tmp
N=0
rtt_total=0
while read line
do
	let N=N+1
	rtt_total=$(echo $rtt_total " + " $line | bc -l)
	read
done < rtt.tmp
rtt_promedio=$(echo $rtt_total " / " $N | bc -l)
echo "@Fabian" >> (Resultados)RTT.txt
echo "RTT TOTAL [FABIAN] = " $rtt_total >> (Resultados)RTT.txt 
echo "RTT PROMEDIO = 0" $rtt_promedio >> (Resultados)RTT.txt
rm -rfv rtt.tmp
