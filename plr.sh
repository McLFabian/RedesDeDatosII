#Calculo de packet lost rate
ip_origen = "192.168.23.172"
ip_destino = "192.168.23.32"
cat file.csv | grep "$ip_origen -> $ip_destino" | grep "Seq="> file_filtrado.tmp #filtra paquete resividos

#rm -rfv file_filtrado.tmp
