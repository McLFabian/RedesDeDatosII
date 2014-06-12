#Calculo de packet lost rate
tshark -r $1 "tcp.analysis.lost_segment" -T fields -e frame.number > LOSSPkt.temp #Primero, se hace un Filtro de todos los Paquetes ACK/Solicitud para contarlos. El Criterio puede ser SEQ Number (Reservado en 126 para éstos ACK), pero es usado de Manera alternativa el Largo de todo Paquete menor igual a 94, ya que éstos varían en 66, 78, 86 y 94 Bytes.
tshark -r $1 "ip.proto==6 && (ip.src==192.168.23.32 && ip.dst==192.168.23.172) && frame.len>=1514" -T fields -e frame.number > PDUFramesTotal.temp #Segundo, se descubre el Número de Paquetes PDU, los cuales, por Criterio, son siempre mayores a 1514B.
TotalPDU=$(wc -l PDUFramesTotal.temp | awk {'print $1'})
LOSS=$(wc -l LOSSPkt.temp | awk {'print $1'})
Porcentaje_aux=$(echo $LOSS" * "100|bc)
echo "--" $TotalPDU
PorcentajePLR=$(echo $Porcentaje_aux" / "$TotalPDU|bc -l)
echo "Packet loss Rate = " $PorcentajePLR" %">>log.txt
rm -rfv LOSSPkt.temp
rm -rfv PDUFramesTotal.temp
