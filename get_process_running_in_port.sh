#!/bin/bash
		
PID=$(fuser $1/tcp)
if [ -e $PID ]; then
    echo "Nenhum processo encontrado para a porta $1"
else
    echo "Matando processo $PID"
    kill -9 $PID
fi
