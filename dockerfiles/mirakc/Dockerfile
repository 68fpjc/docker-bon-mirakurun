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
    && curl --insecure -L https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux/tarball/master \
       | tar -zx --strip-components=1 \
    && make client \
    && chmod 644 BonDriver_Proxy.so \
    && mv BonDriver_Proxy.so /dist/ \
    && mv BonDriver_Proxy.conf /dist/BonDriver_Proxy.so.conf \
    \
    # recbond
    && mkdir -p recbond/ \
    && cd recbond/ \
    && curl --insecure -L https://github.com/dogeel/recbond/tarball/master \
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

# final image
FROM ${BASE} as mirakc
COPY --from=bon-build /dist/BonDriver_Proxy.so /usr/local/lib/
COPY --from=bon-build /dist/BonDriver_Proxy.so.conf /var/lib/BonDriverProxy_Linux/config.in/
COPY --from=bon-build /dist/recbond /usr/local/bin/
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
EXPOSE 40772
