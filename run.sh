echo "">log.txt
chmod +x *
echo "Calculanto RTT Promedio..."
./rtt.sh
echo "Calculando RTT Desviación Estandar..."
./rtt_desv_est.sh
echo "Calculando Throughput..."
./throughput.sh
echo "Calculando PLR..."
./plr.sh
