#!/bin/bash

source _VERSION
_version=$_VERSION
docker build --tag "alpine-influxdb-relay:${_version}"  --no-cache=true .
