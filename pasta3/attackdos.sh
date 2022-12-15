#
# Faz download a cada 2s durante 1min
# para uma maquina

machine=$3

xterm -e vcmd -c $1/$machine -- t50 --flood --turbo -S $2 &
