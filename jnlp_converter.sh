#!/bin/bash

#
# Script que altera as URLs estaticas de todos os jnlps da pasta atual para a URL passada por parametro.
#
# A URL deve ser no formato PROTOCOLO://IP:PORTA/CONTEXTO, por exemplo 192.168.3.130:8080/Detran
#
# Author: Carlos Alexandro Becker
#


IP=$1

function doSed() {
    echo "Convertendo $1"
    mv $1 $1_old
    cat $1_old | sed -e 's,codebase=".*", codebase="'$IP'/applets/",' | sed -e 's,homepage href=".*", homepage href="'$IP'.html",' > $1
    echo "Novo arquivo salvo: $1"
    rm -rf $1_old
    echo ""
}

if [ $# -eq 0 ]; then
    echo "deve ser informada a URL a ser utilizada, por exemplo http://192.168.3.130:8080/Detran".
    exit 0
fi

for i in $(ls *.jnlp); do
    doSed $i
done

for i in $(ls */*.jnlp); do
    doSed $i
done
