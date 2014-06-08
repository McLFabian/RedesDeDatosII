#Thoughput
tshark -r 7 -o column.format:"Time","%Cus:frame.time","Source IP Address","%us","Source Port","%uS","Destination IP Address","%ud","Destination Port","%uD","Protocol","%p","Packet Size","%L" > file.csv
cat file.csv | grep "192.168.23.32 80 192.168.23.172 49567" > server_to_cliente.tmp
rm -rfv file.csv
bits_trasmitidos=0
paquetes_enviados=0
tiempo=0

while read line
do
	bits=$(awk ....)
	let bits_transmitidos=bits_transmitidos+bits
	let paquetes_enviados=paquetes_enviados+1
	
done<server_to_cliente.tmp

thoughput=$(echo "$paquetes_enviados / $tiempo"|bc)

