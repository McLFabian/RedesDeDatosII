#Calculo de packet lost rate
tshark -r 01-Procesado.pcap tcp.seq==126 -T fields -e frame.number > ACKTotal.temp #Primero, se hace un Filtro de todos los Paquetes ACK/Solicitud para contarlos.
tshark -r 01-Procesado.pcap "frame.len>=1514" -T fields -e frame.number > PDUFramesTotal.temp#Segundo, se descubre el Número de Paquetes PDU, los cuales, por Criterio, son siempre mayores a 1514B.
TotalPDU=$(echo wc -l PDUFramesTotal.temp)
TotalACK=$(echo wc -l ACKTotal.temp " - " 1)

TotalPLR = $(echo $TotalACK " - " $TotalPDU)

echo "PLR = " $TotalPLR  >> log.txt
rm -rfv ACKTotal.temp
rm -rfv PDUFramesTotal.temp
