#Thoughput
tshark -r $1 "ip.proto==6 && ip.dst==192.168.23.172 && frame.len>94" -T fields -e frame.len -e frame.time_delta > Frame-LenghtAndTime.log
cat Frame-LenghtAndTime.log | awk -F'	' '{print $1}' > Lenght.tmp
cat Frame-LenghtAndTime.log | awk -F'	' '{print $2}' > Time.tmp
bits=0
tiempo=0

while read line
do
	bits_sum=$(echo "$line * 8")
	bits=$(echo $bits" + "$bits_sum|bc)
done < Lenght.tmp

while read line
do
	tiempo=$(echo $tiempo" + "$line|bc -l)
done < Time.tmp

rm -rfv Lenght.tmp
rm -rfv Time.tmp

Throughput=$(echo $bits" / "$tiempo|bc -l)
echo "Throughput total =" $Throughput >> log.txt
