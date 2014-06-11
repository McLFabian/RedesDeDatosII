#Calculo de packet lost rate
tshark -r 01-Procesado.pcap "frame.len<=94" -T fields -e frame.number > ACKTotal.temp #Primero, se hace un Filt$
tshark -r 01-Procesado.pcap "frame.len>=1514" -T fields -e frame.number > PDUFramesTotal.temp #Segundo, se desc$
TotalPDU=$(echo wc -l PDUFramesTotal.temp)
TotalACK=$(echo wc -l ACKTotal.temp " - " 1)

TotalPLR=$(echo $TotalACK " - " $TotalPDU)

echo "Packet loss Rate = " $TotalPLR  >> 00Resultados-PLR.txt
rm -rfv ACKTotal.temp
rm -rfv PDUFramesTotal.temp
