rm -rfv log.txt
chmod +x *
echo "Calculanto RTT promedio..."
./rtt.sh
echo "Calculando Throughput..."
./throughput.sh
