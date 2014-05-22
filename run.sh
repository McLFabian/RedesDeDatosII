#tshark -r LM_0.49PLRNC.pcap -T fields -e frame.time_relative > file.tmp
#tshark -r LM_0.49PLRNC.pcap -T fields -e frame.number -e tcp.seq -e tcp.len -e frame.time_relative > file.csv
cat file.csv | awk {'print $2'} > frames_repetidos.txt
packet_lost=0;
packet=0;
while read line
do
	#num=$(echo $line | awk {'print $1'})
	#num_frame=$(echo $line | awk {'print $2'} )
	#if [ $num_frame -le $num ];then
		 let packet_lost=$packet_lost+1
	#fi
	#let packet=$packet+1
	clear
	echo "Packet Lost :"$packet_lost
done<frames_repetidos.txt
echo "Paquetes perdidos :" $packet_lost
echo "Paquetes total :" $packet
#cat -ns file.tmp > file.csv

