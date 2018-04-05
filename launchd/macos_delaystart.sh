#!/bin/sh

delay=$1
shift
cmd=$1
shift

sleep $delay
exec $cmd "$@"
