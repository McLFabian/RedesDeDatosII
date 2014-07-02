echo "">log.txt
chmod +x *
echo "Calculanto RTT Promedio..."
./rtt.sh $1
echo "Calculando RTT Desviación Estandar..."
./rtt_desv_est.sh $1
echo "Calculando Throughput..."
./throughput.sh $1
echo "Calculando PLR..."
./plr.sh $1
