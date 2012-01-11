#!/bin/bash
#
# Para as pessoas masculinas que utilizam *nix.
# Roda os ants de construção dos applets na pasta do projeto, 
# depois roda o ant que gera o war, copia o war para a pasta 
# webapps do jetty e executa o servidor.
#
# author: Carlos Alexandro Becker
#

#vars
PROJECT_FOLDER=~/workspace/Detran/
JETTY_HOME=~/software/jetty-hightide-8.0.4.v20111024/
WAR_BASE=detran*.war
WAR_DEST=Detran.war
BUILD_APPLET=0
BUILD_WAR=0
START_SERVER=0


# entra na pasta do projeto
cd $PROJECT_FOLDER

if [ $# -eq 0 ]; then
    echo "Informe uma ou mais opcoes: applet, war, server ou all"
    exit 0
fi

for param in $*; do
    case $param in
        applet) BUILD_APPLET=1 ;;
        war)  BUILD_WAR=1 ;;
        server) START_SERVER=1 ;;
        all) START_SERVER=1; BUILD_WAR=1; BUILD_APPLET=1 ;;
    esac
done

# apaga os lixos antigos, se eles existirem, claro
rm -rf $WAR_DEST
rm -rf $WAR_BASE

# compila todos os builds xml, menos o build.xml,
# porque ele pode acabar compilando o build antes dos
# builds dos applets, daí vai desatualizado as coisas.
if [ $BUILD_APPLET -eq 1 ]; then
    for i in $(ls build*.xml | grep -v build.xml); do
        ant -f $i
    done
fi

# constroi o war da app
if [ $BUILD_WAR -eq 1 ]; then
    ant -f build.xml

    # renomeia para $WAR_DEST
    ls $WAR_BASE
    mv $WAR_BASE $WAR_DEST

fi


# entra na pasta do jetty e executa ele :)
if [ $START_SERVER -eq 1 ]; then
    # move o war para a pasta webapps do jetty
    mv $WAR_DEST $JETTY_HOME/webapps/

    cd $JETTY_HOME
    java -jar start.jar
fi

exit 0
