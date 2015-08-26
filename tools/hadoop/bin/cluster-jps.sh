#!/bin/sh

# set usage
commands="[-q] [-mlvV]"
usage="Usage: $0 $commands"

# set print usage function
function print_usage(){
  echo $usage
}

# if no args specified, show usage
# lt 0, never happend!
if [ $# -lt 0 ]; then
  echo $usage
  exit 1
fi

# get args
MY_OP=$1
#shift

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
MY_HOME=${JAVA_HOME:-'/usr/java/jdk1.7.0_25'}

# set host name prefix
HOST_PREFIX='centos14'

# ssh
for id in {1..7}; do
  case $id in
  5|6)
    continue
  ;;
  esac

  echo ' '
  echo "=== ${HOST_PREFIX}$id ==="

  if [ "$DEBUG_FLAG" = 'on' ]; then
    echo "ssh -t ${HOST_PREFIX}$id ${MY_HOME}/bin/jps $commands"
  else
    ssh -t ${HOST_PREFIX}$id ${MY_HOME}/bin/jps $1 $2
  fi

  echo ' '
done
