FROM masnagam/mirakc:master-debian

RUN : \
    && set -x \
    && apt-get update \
    \
    # BonDriverProxy_Linux client
    && apt-get install -y --no-install-recommends ca-certificates curl make g++ autoconf automake \
    && mkdir -p /build/ \
    && cd /build/ \
    && curl -L https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux/tarball/master \
       | tar -zx --strip-components=1 \
    && make client \
    && install -m 644 BonDriver_Proxy.so /usr/local/lib/ \
    && mkdir -p /var/lib/BonDriverProxy_Linux/config.in/ \
    && cp BonDriver_Proxy.conf /var/lib/BonDriverProxy_Linux/config.in/BonDriver_Proxy.so.conf \
    && mkdir -p recbond/ \
    && cd recbond/ \
    && curl -L https://github.com/dogeel/recbond/tarball/master \
       | tar -zx --strip-components=1 \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make \
    && install -m 755 recbond /usr/local/bin/ \
    && cd ../../ \
    && rm -r /build/ \
    \
    # arib-b25-stream-test
    && apt-get install -y --no-install-recommends npm make pkg-config g++ libpcsclite-dev \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs make pkg-config g++ libpcsclite-dev \
    && npm install arib-b25-stream-test -g --unsafe-perm \
    && apt-get install -y --no-install-recommends libpcsclite1 \
    \
    && apt-get remove -y ca-certificates curl make g++ autoconf automake npm pkg-config libpcsclite-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    \
    && :

COPY services.sh /
ENTRYPOINT ["/services.sh"]
CMD []

EXPOSE 40772
