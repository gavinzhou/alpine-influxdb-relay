#!/bin/sh
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- influxdb-relay "$@"
fi

exec "/sbin/dumb-init" "$@"
