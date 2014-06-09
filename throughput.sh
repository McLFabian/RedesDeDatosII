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
	echo $paquetes_enviados
done < packet.tmp

rm -rfv packet.tmp
tiempo=$(cat log.txt | grep "RTT_TOTAL" | awk {'print $2'})
throughput=$(echo "$paquetes_enviados / $tiempo"|bc)
echo "TOTAL PAQUETES ENVIADOS "$paquetes_enviaos >>log.txt
echo "TOTAL PAQUETES ENVIADOS "$paquetes_enviaos
echo "THROUGHPUT "$throughput>>log.txt
echo "THROUGHPUT "$throughput

