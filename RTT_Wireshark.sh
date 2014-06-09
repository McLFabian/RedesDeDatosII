#RTT: Medición promedio (para .csv desde Wireshark)
cat 02-TraficoSoloRecibido.csv | awk -F'"' '{print $4}' > rtt.tmp
N=0
rtt_total=0
anterior=0
while read line
do
	rtt=0
	rtt=$(echo $line " - " $anterior | bc -l  )
	let N=N+1
	rtt_total=$(echo $rtt_total " + " $rtt | bc -l)
	anterior=$line
	read
done < rtt.tmp
rtt_promedio=$(echo $rtt_total " / " $N | bc -l)
echo "RTT PROMEDIO = " $rtt_promedio > RTTPromedio.txt
rm -rfv rtt.tmp
