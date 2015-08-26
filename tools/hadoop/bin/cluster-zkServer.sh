#!/bin/sh

# set usage
commands="(start|start-foreground|stop|restart|status|upgrade|print-cmd)"
usage="Usage: $0 $commands"

# set print usage function
function print_usage(){
  echo $usage
}

# if no args specified, show usage
if [ $# -lt 1 ]; then
  echo $usage
  exit 1
fi

# get args
MY_OP=$1
shift

# show usage for help
case $MY_OP in
  # usage flags
  --help|-help|-h)
    print_usage
    exit
    ;;
esac

DEBUG_FLAG='off'
case $MY_OP in
  # debug flags
  --test|--debug|-test|-debug)
    DEBUG_FLAG='on'
    ;;
esac

# set home path
MY_HOME=${ZOOKEEPER_HOME:-'/mycluster/zookeeper-3.4.5-cdh5.4.3'}

# set host name prefix
HOST_PREFIX='centos14'

# ssh
for id in 1 2 7; do
  echo ' '
  echo "=== ${HOST_PREFIX}$id ==="
  
  if [ "$DEBUG_FLAG" = 'on' ]; then
    echo "ssh -t ${HOST_PREFIX}$id ${MY_HOME}/sbin/zkServer.sh $commands"
  else
    ssh -t ${HOST_PREFIX}$id ${MY_HOME}/sbin/zkServer.sh $MY_OP
  fi
  
  echo ' '
done
