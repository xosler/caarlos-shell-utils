#!/bin/bash

# particao da swap
PARTICAO=/dev/sda5

# desliga a swap e liga novamente
echo "limpando a swap: " $PARTICAO
swapoff $PARTICAO
swapon $PARTICAO

# limpa o cache da memoria
echo "limpando o cache da ram..."
echo 3 > /proc/sys/vm/drop_caches
sysctl -w vm.drop_caches=3
