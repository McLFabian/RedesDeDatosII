#rtt medicón promedio
tshark -r 7 -o column.format:""No","%m","Time","%t","Source","%s","Destination","%d","Protocol", "%p","info", "%i""  >file.csv
cat file.csv | grep "192.168.23.32 -> 192.168.23.172" > server_to_cliente.tmp
rm -rfv file.csv
cat server_to_cliente.tmp | awk {'print $2'} > rtt.tmp
rm -rfv server_to_cliente.csv
N=0
rtt_total=0
ant=0
while read line
do
	rtt=0
	let N=N+1
	rtt=$(echo $line" - "$ant|bc)
	rtt_total=$(echo $rtt_total" + "$rtt|bc)
	#echo $rtt_total
	ant=$line
	read
done < rtt.tmp
#echo "RTT TOTAL :" $rtt_total
#echo "N : " $N
rtt_promedio=$(echo "scale=10;$rtt_total / $N"|bc)
echo "RTT_PROMEDIO " $rtt_promedio " segundos" >> rtt_promedio.txt > log.txt #Escrive el resultado en el log
echo "RTT PROMEDIO :" $rtt_promedio " segundos"
rm -rfv rtt.tmp
