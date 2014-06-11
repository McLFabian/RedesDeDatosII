#Thoughput
tshark -r 02-TráficoSóloRecibido.pcap -T fields -e frame.lenght -e frame.time_delta > Frame-LenghtAndTime.log #Aquí está entregando sólo el Time,, FALLO.
cat Frame-LenghtAndTime.log | awk -F'	' '{print $1}' > Lenght.tmp
cat Frame-LenghtAndTime.log | awk -F'	' '{print $2}' > Time.tmp
rm -rfv file.csv
rm -rfv server_to_cliente.tmp
bits_trasmitidos=0
paquetes_enviados=0

while read line
do
	bits=0
	bits_sum=$(echo '$line "*" 8')
	bits=$(echo $bits "+" $bits_sum)
done < Lenght.tmp

while read line
do
	tempo=0
	tempo=$(echo $tempo "+" $line|bc -l)
done < Time.tmp

rm -rfv Lenght.tmp
rm -rfv Time.tmp

Throughput=$(echo $bits "/" $tempo |bc -l)
echo "Throughput total =" $Throughput >> (Resultado)Throughput.txt
