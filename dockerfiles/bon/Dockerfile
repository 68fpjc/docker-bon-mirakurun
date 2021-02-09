FROM debian:stretch-slim
RUN : \
    && set -x \
    && apt-get update \
    \
    # BonDriverProxy_Linux server & driver
    && apt-get install -y --no-install-recommends ca-certificates curl make g++ \
    && mkdir -p /build/ \
    && cd /build/ \
    && curl -L https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux/tarball/master \
       | tar -zx --strip-components=1 \
    && BUILD=DEBUG make server driver \
    && install -m 755 BonDriverProxy /usr/local/bin/ \
    && install -m 644 *.so BonDriver_DVB.conf BonDriver_Splitter.conf /usr/local/lib/ \
    && mkdir -p /var/lib/BonDriverProxy_Linux/ \
    && cd / \
    && rm -r /build/ \
    \
    # cleanup
    && apt-get remove -y ca-certificates curl make g++ autoconf automake pkg-config libpcsclite-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && :
COPY entrypoint.sh /
COPY BonDriver_LinuxPT.conf /usr/local/lib/
ENTRYPOINT ["/entrypoint.sh"]
CMD []
EXPOSE 1192
