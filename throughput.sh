#Thoughput
tshark -r $1 "ip.proto==6 && ip.dst==192.168.23.172 && frame.len>94" -T fields -e frame.len -e frame.time_delta > Frame-LenghtAndTime.log
cat Frame-LenghtAndTime.log | awk -F'	' '{print $1}' > Lenght.tmp
cat Frame-LenghtAndTime.log | awk -F'	' '{print $2}' > Time.tmp
bits=0
tiempo=0

while read line
do
	bits_sum=$(echo "$line * 8"|bc)
	bits=$(echo $bits" + "$bits_sum|bc)
done<Lenght.tmp

<<<<<<< HEAD
rm -rfv packet.tmp
tiempo=$(cat log.txt | grep "RTT_TOTAL" | awk {'print $2'})
throughput=$(echo "$paquetes_enviados / $tiempo"|bc)
echo "Paquetes enviados "$paquetes_enviados" timepo "$tiempo
echo "TOTAL PAQUETES ENVIADOS "$paquetes_enviados >>log.txt
echo "TOTAL PAQUETES ENVIADOS "$paquetes_enviados
echo "THROUGHPUT "$throughput "paquetes/segundo">>log.txt
echo "THROUGHPUT "$throughput "paquetes/segundo"
echo "PESO DEL ARCHIVO "$bits_transmitidos "bytes">>log.txt
echo "PESO DEL ARCHIVO "$bits_transmitidos "bytes"
bps=$(echo $bits_transmitidos" / "$tiempo|bc)
echo "BYTES/SEGUNDO PROMEDIO "$bps "Bps" >>log.txt
echo "BYTES/SEGUNDO PRIMEDIO "$bps "Bps"
=======
echo "paso lenght"

while read line
do
	tiempo=$(echo $tiempo" + "$line|bc -l)
done<Time.tmp

echo "paso time"

rm -rfv Lenght.tmp
rm -rfv Time.tmp

Throughput=$(echo $bits" / "$tiempo|bc -l)
echo "Throughput total =" $Throughput >> log.txt
>>>>>>> fbe635aa0e68035ceba6c21c6a9ab1d4f4e758a1
