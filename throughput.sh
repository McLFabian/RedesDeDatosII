#Thoughput
tshark -r 7 -o column.format:"Time","%Cus:frame.time","Source IP Address","%us","Source Port","%uS","Destination IP Address","%ud","Destination Port","%uD","Protocol","%p","Packet Size","%L" > file.csv
cat file.csv | grep "192.168.23.32 80 192.168.23.172 49567" > server_to_cliente.tmp
cat server_to_cliente.tmp | awk {'print $11'} > packet.tmp
rm -rfv file.csv
rm -rfv server_to_cliente.tmp
bits_trasmitidos=0
paquetes_enviados=0

while read line
do
	bits=line
	let bits_transmitidos=bits_transmitidos+bits
	let paquetes_enviados=paquetes_enviados+1
done < packet.tmp

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
bps=$(echo "$bits_trasmitidos / $tiempo"|bc)
echo "BYTES/SEGUNDO PROMEDIO "$bps "bps" >>log.txt
echo "BYTES/SEGUNDO PRIMEDIO "$bps "bps"
