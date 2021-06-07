#!/bin/bash

source .env
source env.sh
remove_container() {
    NAME=$1
    docker rm -f $(docker container ls -a | grep $NAME | grep -v COMMAND | awk {'print $1'})
}

quickstart(){
    docker compose up;
}
stop() {
    docker compose down;
}
upbuild() {
    docker compose up --build;
}

reboot() {
    stop
    upbuild
}

restart() {
    stop
    quickstart
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in

    -r|--remove)
        REMOVE_TARGET="$2"
        remove_container $REMOVE_TARGET
    shift
    shift
    ;;

    --setup)
        bash setup.sh
    shift
    ;;

    -r|--rebuild)
        reboot
    shift
    ;;

    -r|--restart)
        up
    shift
    ;;

    -b|--build)
        build
    shift
    ;;

    -s|--start|--run)
        upbuild
    shift
    ;;

    -q|--quick|--quick-start)
        up
    shift
    ;;

    --stop|--down)
        stop
    shift
    ;;
esac
done