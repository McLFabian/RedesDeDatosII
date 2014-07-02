#Thoughput
tshark -r $1 "(ip.proto == 17 && frame.len>590) && (udp.dstport == 15200)" -T fields  -e frame.len -e frame.time_delta > Frame-LenghtAndTime.log
cat Frame-LenghtAndTime.log | awk -F'	' '{print $1}' > Lenght.tmp
cat Frame-LenghtAndTime.log | awk -F'	' '{print $2}' > Time.tmp
bits=0
tiempo=0

while read line
do
	bits_sum=$(echo "$line * 8"|bc)
	bits=$(echo $bits" + "$bits_sum|bc)
done<Lenght.tmp

echo "paso lenght"

while read line
do
	tiempo=$(echo $tiempo" + "$line|bc -l)
done<Time.tmp

echo "paso time"

rm -rfv Lenght.tmp
rm -rfv Time.tmp
rm -rfv Frame-LenghtAndTime.log

Throughput=$(echo $bits" / "$tiempo|bc -l)
echo "Throughput total =" $Throughput >> log.txt
