ARG BASE

# BonDriverProxy_Linux client
FROM ${BASE} as bon-build
RUN : \
    && set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl make g++ autoconf automake \
    \
    && mkdir -p /dist/ \
    \
    # BonDriverProxy_Linux client
    && mkdir -p /build/ \
    && cd /build/ \
    && curl -L https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux/tarball/master \
       | tar -zx --strip-components=1 \
    && make client \
    && chmod 644 BonDriver_Proxy.so \
    && mv BonDriver_Proxy.so /dist/ \
    && mv BonDriver_Proxy.conf /dist/BonDriver_Proxy.so.conf \
    \
    # recbond
    && mkdir -p recbond/ \
    && cd recbond/ \
    && curl -L https://github.com/dogeel/recbond/tarball/master \
       | tar -zx --strip-components=1 \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local \
    && make \
    && mv recbond /dist/ \
    \
    && rm -rf /build/ \
    \
    # cleanup
    && apt-get remove -y ca-certificates curl make g++ autoconf automake \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && :

# Mirakurun with arib-b25-stream-test
FROM ${BASE} as mirakurun
ARG MIRAKURUN_VER
ENV DOCKER="YES"
RUN : \
    && set -x \
    && apt-get update \
    \
    # Mirakurun
    && npm install mirakurun@${MIRAKURUN_VER} -g --production \
    \
    # arib-b25-stream-test
    && apt-get install -y --no-install-recommends make pkg-config g++ libpcsclite-dev \
    && npm install arib-b25-stream-test -g --unsafe-perm \
    && apt-get install -y --no-install-recommends libpcsclite1 \
    \
    # cleanup
    && apt-get remove -y make pkg-config g++ libpcsclite-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && :
COPY --from=bon-build /dist/BonDriver_Proxy.so /usr/local/lib/
COPY --from=bon-build /dist/BonDriver_Proxy.so.conf /var/lib/BonDriverProxy_Linux/config.in/
COPY --from=bon-build /dist/recbond /usr/local/bin/
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
EXPOSE 40772