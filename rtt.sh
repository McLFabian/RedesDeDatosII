#rtt medicón promedio
####tshark -r 7 -o -E separator=, column.format:""No","%m","Time","%t","Source","%s","Destination","%d","Protocol", "%p","info", "%i""  >file.csv
tshark -r 7 -T fields -E separator=, -e frame.number -e frame.time_delta -e ip.src -e ip.dst -e tcp.seq -e tcp.nxtseq > file.csv
cat file.csv | grep "192.168.23.32,192.168.23.172" > server_to_cliente.tmp
rm -rfv file.csv
cat server_to_cliente.tmp | awk -F ',' {'print $2'} > rtt.tmp
rm -rfv server_to_cliente.csv
N=0
rtt_total=0
while read line
do
	rtt=0
	let N=N+1
	rtt_total=$(echo $rtt_total" + "$line|bc)
done < rtt.tmp

rm -rfv rtt.tmp

#echo "RTT TOTAL :" $rtt_total
#echo "N : " $N

rtt_promedio=$(echo "scale=10;$rtt_total / $N"|bc)
echo "RTT_TOTAL " $rtt_total " segundos" >>  log.txt #Escrive el resultado en el log
echo "RTT_PROMEDIO " $rtt_promedio " segundos" >> log.txt #Escrive el resultado en el log
echo "RTT TOTAL : " $rtt_total
echo "RTT PROMEDIO :" $rtt_promedio " segundos"
