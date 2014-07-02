#RTT: Medición promedio
tshark -r $1 "(ip.proto == 17 && frame.len>590) && (udp.dstport == 15200)" -T fields -e  frame.time_delta > Frame-RelativeTime.log
cat Frame-RelativeTime.log | awk -F'	' '{print $1}' > rtt.tmp
N=0
rtt_total=0
while read line
do
	let N=N+1
	#rtt_total=$(echo $rtt_total" + "$line |bc -l)
	#read
done < rtt.tmp

echo "PLR SERVIDOR :"$N

rm -rfv rtt.tmp
rm -rfv Frame-RelativeTime.log

