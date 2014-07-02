#RTT: Medición promedio
tshark -r $1 "(ip.proto == 17 && !frame.len<=590) && (udp.dstport == 15200)" -T fields -e  frame.time_delta > Frame-RelativeTime.log
cat Frame-RelativeTime.log | awk -F'	' '{print $1}' > rtt.tmp
N=0
rtt_total=0
while read line
do
	let N=N+1
	rtt_total=$(echo $rtt_total" + "$line |bc -l)
	read
done < rtt.tmp
rtt_promedio=$(echo $rtt_total" / "$N |bc -l)

rtt_total_2=$(echo $rtt_total" * 2"|bc -l) #RTT DE DOS VIAS
rtt_promedio_2=$(echo $rtt_promedio" * 2"|bc -l) #RTT PROMEDIO DOS VIAS

echo "RTT TOTAL = " $rtt_total_2 >> log.txt
echo "RTT PROMEDIO = 0" $rtt_promedio_2 >> log.txt

#rm -rfv rtt.tmp
#rm -rfv Frame-RelativeTime.log
