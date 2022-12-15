
data=$1

hora=$2

minIni=$3
minFim=$4

entrada=$5

# echo $init
# echo $end

# editcap -F libpcap -A "2022-12-03 11:31:36" -B "2022-12-03 11:32:36" ./pcap/captura2.cap fil-cap.cap
for j in $(seq $minIni $minFim)
do
  for i in $(seq 0 5)
  do
    # echo $data $hora:$j:$i"0" e $data $hora:$j:$((($i+1)*10))
    editcap -F libpcap -A "$data $hora:$j:$i"0"" -B "$data $hora:$j:$((($i+1)*10))" $entrada ./pcap/fil/fil-cap-$j:$i.cap
  done
done

ls ./pcap/fil -l | grep "fil" | awk '{print $9}' > ./filesNames

