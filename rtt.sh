#RTT: Medición promedio
tshark -r $1 -T fields -e frame.number -e tcp.seq -e tcp.nxtseq -e frame.time_delta > Frame-RelativeTime.log
cat Frame-RelativeTime.log | awk -F'	' '{print $4}' > rtt.tmp
N=0
rtt_total=0
while read line
do
	let N=N+1
	rtt_total=$(echo $rtt_total" + "$line |bc -l)
	read
done < rtt.tmp
rtt_promedio=$(echo $rtt_total" / "$N |bc -l)
echo "RTT TOTAL = " $rtt_total >> log.txt 
echo "RTT PROMEDIO = 0" $rtt_promedio >> log.txt
rm -rfv rtt.tmp
