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
DETRAN_PROJECT=~/workspace/Detran/
JETTY_HOME=~/software/jetty-hightide-8.0.4.v20111024/
BUILD_APPLET=0
BUILD_WAR=0
START_SERVER=0
CLEAN=0

function clean() {
    echo "::clean"
    rm -rf Detran.war
    rm -rf dtran*.war
    rm -rf build/
    rm -rf gwt-unitCache/
    rm -rf war/server_resources/
    rm -rf war/WEB-INF/deploy/
    rm -rf war/Detran/
    rm -rf apt_generated/*
}

function buildApplets() {
    echo "::buildApplets"
    for i in $(ls build*.xml | grep -v build.xml); do
        ant -f $i deploy
    done
}

function buildWar() {
    echo ":: buildWar"
    ant -f build.xml

    # renomeia para Detran.war
    ls detran*.war
}


function startServer() {
    echo "::startServer"
    # move o war para a pasta webapps do jetty
    mv detran*.war Detran.war
    
    mv Detran.war $JETTY_HOME/webapps/
    
    # copia o detran.properties com -force
    # cp war/detran.properties $JETTY_HOME -f nao é mais necessario!
    
    cd $JETTY_HOME
    java -jar start.jar
}

# entra na pasta do projeto
cd $DETRAN_PROJECT

if [ $# -eq 0 ]; then
    echo "Informe uma ou mais opcoes: applet, war, server, clean ou all"
fi

for param in $*; do
    case $param in
        applet) BUILD_APPLET=1 ;;
        war)  BUILD_WAR=1 ;;
        server) START_SERVER=1 ;;
        clean) CLEAN=1 ;;
        all) START_SERVER=1; BUILD_WAR=1; BUILD_APPLET=1; CLEAN=1 ;;
    esac
done

# apaga os lixos antigos, se eles existirem, claro
if [ $CLEAN -eq 1 ]; then
	clean
fi

# compila todos os builds xml, menos o build.xml,
# porque ele pode acabar compilando o build antes dos
# builds dos applets, daí vai desatualizado as coisas.
if [ $BUILD_APPLET -eq 1 ]; then
    buildApplets
fi

# constroi o war da app
if [ $BUILD_WAR -eq 1 ]; then
    buildWar
fi

if [ $CLEAN -eq 1 ]; then
	clean
fi

# entra na pasta do jetty e executa ele :)
if [ $START_SERVER -eq 1 ]; then
   startServer 
fi


