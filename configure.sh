#!/bin/sh

usage()
{
    echo -e "usage  : configure.sh start <env>\nexample: configure.sh start prod"
}

if [ "$1" != "" ]; then
    ACTION=$1
    ENV=$2
else
	usage
    exit 1
fi

DIR=$(dirname "$0")
cd $DIR

case $ACTION in
    start)
        docker-compose -f docker-compose.yaml -f docker-compose_$ENV.yaml up --remove-orphans -d
        ;;
    stop)
        docker-compose -f docker-compose.yaml -f docker-compose_$ENV.yaml stop
        ;;
    delete)
        docker-compose -f docker-compose.yaml -f docker-compose_$ENV.yaml down
        ;;
    backup)
        mkdir backup 2>/dev/null
        tar czv --exclude=backup -f backup/zabbix-docker_$ENV.tar.gz .
        ;;
    restore-unsafe)
        echo NEVER USE THIS IN PROD
        echo Will delete everything from $DIR directory
        echo Press Ctrl+C to abort or wait 60 seconds to start
        sleep 60
        find $DIR -not -ipath '*backup*' -not -ipath '*configure.sh' -delete
        tar xvf $DIR/backup/zabbix-docker_$ENV.tar.gz -C $DIR/
        ;;
    build)
        docker-compose -f docker-compose.yaml build
        ;;
esac



