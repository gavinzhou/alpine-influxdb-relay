FROM alpine:3.4
MAINTAINER gavin zhou <gavin.zhou@gmail.com>

RUN export GOPATH=/go \
    && PATH=$PATH:$GOPATH/bin \
    && apk update \
    && apk add --virtual .build-deps build-base go git \
    && go get -u github.com/influxdata/influxdb-relay \
    && mkdir /config \
    && cp $GOPATH/src/github.com/influxdata/influxdb-relay/sample.toml /config/relay.toml \
    && cp $GOPATH/bin/influxdb-relay /bin/ \
    && apk del .build-deps \
    && rm -rf /go /tmp/* /var/cache/apk/* /root/.n* 

#reply port
EXPOSE 9096

ENTRYPOINT ["/bin/influxdb-relay"]
CMD ["-config", "/config/relay.toml"]
