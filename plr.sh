#Calculo de packet lost rate
ip_origen = "192.168.23.32"
ip_destino = "192.168.23.172"
cat -n file.csv | grep "$ip_origen -> $ip_destino"> file_filtrado.tmp #filtra paquete resividos
less file_filtrado.tmp


rm -rfv file_filtrado.tmp
