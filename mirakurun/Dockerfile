FROM keymetrics/pm2:10-alpine

ENV DOCKER="YES"

WORKDIR /app/

RUN : \
    && set -x \
    && apk update \
    \
    && mkdir client/ \
    && mkdir client/config.in/ \
    \
    && apk add --virtual .build_deps \
       git build-base autoconf automake pcsc-lite-dev curl \
    \
    # && apk add --virtual .build_deps git build-base autoconf automake \
    && git clone https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux.git tmp \
    && cd tmp/ \
    && make client \
    && mv BonDriver_Proxy.so .. \
    && mv BonDriver_Proxy.conf ../client/config.in/ \
    && git clone https://github.com/dogeel/recbond.git \
    && cd recbond/ \
    && sed -E "s|^(#include <sys/stat.h>)$|\1\n#include <sys/types.h>|" -i tssplitter_lite.c \
    && ./autogen.sh \
    && ./configure \
    && make \
    && mv recbond ../.. \
    && cd ../.. \
    && rm -rf tmp \
    # && apk del --purge .build_deps \
    \
    # && apk add --virtual .build_deps build-base pcsc-lite-dev \
    && npm install arib-b25-stream-test -g --unsafe-perm \
    # && apk del --purge .build_deps \
    && apk add pcsc-lite-libs \
    \
    && npm install mirakurun -g --unsafe-perm --production \
    && apk add bash \
    # && mirakurun init \
    \
    # && apk add --virtual .build_deps curl \
    && curl -LO https://github.com/vishnubob/wait-for-it/raw/master/wait-for-it.sh \
    && chmod +x wait-for-it.sh \
    # && apk del --purge .build_deps \
    \
    && apk del --purge .build_deps \
    && :

COPY services.sh .
CMD ["./services.sh"]

EXPOSE 40772
