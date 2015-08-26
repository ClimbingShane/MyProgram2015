#!/bin/sh

# set usage
commands="(start|stop)"
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
MY_HOME=${HADOOP_HOME:-'/mycluster/hadoop-2.6.0-cdh5.4.3'}

# set server name
SERVER_NAME='journalnode'

# set host name prefix
HOST_PREFIX='centos14'

# ssh
for x in 1 2 7; do
  echo ' '
  echo "=== ${HOST_PREFIX}$x ==="

  if [ "$DEBUG_FLAG" = 'on' ]; then
    echo 'use the journal node dir:'
    ssh -t ${HOST_PREFIX}$x ${MY_HOME}/bin/hdfs getconf -confKey dfs.journalnode.edits.dir
    echo "ssh -t ${HOST_PREFIX}$x ${MY_HOME}/sbin/hadoop-daemon.sh $commands $SERVER_NAME"
  else
    ssh -t ${HOST_PREFIX}$x ${MY_HOME}/sbin/hadoop-daemon.sh $MY_OP $SERVER_NAME
  fi

  echo ' '
done
