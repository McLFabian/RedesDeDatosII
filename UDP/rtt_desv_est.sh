#rtt medición Desviación Estándar
# Para la Desviación Estándar es necesario calcular la Raíz cuadrada de la Varianza, para lo cuál la Fórmula es: 
#Desviación Estándar = Varianza^(1/2) = [((Sumatoria de 1 hasta n de: (Ai - Media))^(2))/n]^(1/2)
#Cálculo de Promedio
tshark -r $1 "(ip.proto == 17 && frame.len>590) && (udp.dstport == 15200)" -T fields -e frame.time_delta > Frame-RelativeTime.log
cat Frame-RelativeTime.log | awk -F'	' '{print $1}' > rtt.tmp
N=0
rtt_total=0
anterior=0
while read line
do
	let N=N+1
	rtt_total=$(echo $rtt_total" + "$line|bc -l)
	read
done < rtt.tmp

rtt_promedio=$(echo $rtt_total" / "$N|bc -l)
#rtt_promedio=$(echo $rtt_total" * 2"|bc -l) #RTT PROMEDIO DOS VIAS

# Cálculo de la Varianza
N=0
rtt_varianza=0
anterior=0
while read line
do
	rtt_varianza_unidad=0
	rtt_varianza_unidad_aux=0
	rtt_varianza_unidad_aux=$(echo $line" - "$rtt_promedio|bc -l)
	rtt_varianza_unidad_aux=$(echo $rtt_varianza_unidad_aux" * 2"|bc -l)
	rtt_varianza_unidad=$(echo $rtt_varianza_unidad_aux" * "$rtt_varianza_unidad_aux|bc -l)
	let N=N+1
	rtt_varianza=$(echo $rtt_varianza" + "$rtt_varianza_unidad|bc -l)
	anterior=$line
	read
done < rtt.tmp
# Cálculo de Desviación Estándar
aux=$(echo $rtt_varianza" / " $N|bc -l)
rtt_desviacion=$(echo "sqrt($aux)"|bc -l)
echo "Desviacion Estandar RTT = " $rtt_desviacion >> log.txt
rm -rfv rtt.tmp
rm -rfv Frame-RelativeTime.log
