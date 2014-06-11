#Calculo de packet lost rate
tshark -r 01-Procesado.pcap "frame.len<=94" -T fields -e frame.number > ACKTotal.temp #Primero, se hace un Filtro de todos los Paquetes ACK/Solicitud para contarlos. El Criterio puede ser SEQ Number (Reservado en 126 para éstos ACK), pero es usado de Manera alternativa el Largo de todo Paquete menor igual a 94, ya que éstos varían en 66, 78, 86 y 94 Bytes.
tshark -r 01-Procesado.pcap "frame.len>=1514" -T fields -e frame.number > PDUFramesTotal.temp #Segundo, se descubre el Número de Paquetes PDU, los cuales, por Criterio, son siempre mayores a 1514B.
TotalPDU=$(echo wc -l PDUFramesTotal.temp)
TotalACK=$(echo wc -l ACKTotal.temp " - " 1)

TotalPLR = $(echo $TotalACK " - " $TotalPDU)

echo "Packet loss Rate = " $TotalPLR  >> (Resultados)PLR.txt
rm -rfv ACKTotal.temp
rm -rfv PDUFramesTotal.temp
