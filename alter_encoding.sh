#!/bin/bash
ARQUIVO=$1
CODIFICACAO_ORIGEM=`file -i $ARQUIVO | grep charset | cut -f2 -d'='`
CODIFICACAO_DESTINO=$2
echo "convertendo arquivo " $ARQUIVO " de " $CODIFICACAO_ORIGEM " para " $CODIFICACAO_DESTINO "..."
cat $ARQUIVO | iconv -f $CODIFICACAO_ORIGEM -t $CODIFICACAO_DESTINO -o $ARQUIVO"_"$CODIFICACAO_DESTINO

file -i $ARQUIVO"_"$CODIFICACAO_DESTINO #vai mostrar o encoding original do arquivo

#iconv -l #lista todas as codificacoes possiveis
