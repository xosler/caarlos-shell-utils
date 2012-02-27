#!/bin/bash

function run() {
    echo "iniciando servico do openoffice...."
    soffice --headless --accept="socket,host=127.0.0.1,port=8100;urp;" --nofirststartwizard &
}

PID=$(fuser 8100/tcp)
if [ -z $PID ]; then 
   run
fi
