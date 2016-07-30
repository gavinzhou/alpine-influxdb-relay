FROM alpine:3.4
MAINTAINER gavin zhou <gavin.zhou@gmail.com>

RUN export GOPATH=/go \
    && PATH=$PATH:$GOPATH/bin \
    && apk update \
    && apk add --virtual .build-deps build-base go git curl make gcc musl-dev \
    && curl -sSL https://github.com/Yelp/dumb-init/archive/master.tar.gz | tar -xz \
    && cd dumb-init-master && gcc -std=gnu99 -s -Wall -Werror -O3 -o /sbin/dumb-init /dumb-init-master/dumb-init.c \
    && go get -u github.com/influxdata/influxdb-relay \
    && mkdir /config \
    && cp $GOPATH/src/github.com/influxdata/influxdb-relay/sample.toml /config/relay.toml \
    && cp $GOPATH/bin/influxdb-relay /bin/ \
    && apk del .build-deps \
    && rm -rf /go /tmp/* /var/cache/apk/* /root/.n* /dumb-init-master*

#reply port
EXPOSE 9096

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/influxdb-relay", "-config", "/config/relay.toml"]
