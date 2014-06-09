#tshark -r 7 -T fields -e frame.number -e tcp.seq -e tcp.len -e (tcp.syn || tcp.ack)  -e frame.time_relative > file.csv
tshark -r 7 -o column.format:""No","%m","Time","%t","Source","%s","Destination","%d","Protocol","%p","info", "%i""  >file.csv

