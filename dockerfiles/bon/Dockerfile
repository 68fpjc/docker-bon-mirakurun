FROM debian:buster-slim
RUN : \
    && set -x \
    && apt-get update \
    \
    && mkdir /build/ \
    \
    # BonDriverProxy_Linux server & driver
    && mkdir BonDriverProxy_Linux/ \
    && cd BonDriverProxy_Linux/ \
    && apt-get install -y --no-install-recommends curl make g++ \
    && curl --insecure -L https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux/tarball/master \
       | tar -zx --strip-components=1 \
    && make server driver \
    && install -m 755 BonDriverProxy /usr/local/bin/ \
    && install -m 644 *.so BonDriver_DVB.conf BonDriver_Splitter.conf /usr/local/lib/ \
    && mkdir -p /var/lib/BonDriverProxy_Linux/ \
    && cd ../ \
    \
    # BonDriver_LinuxPTX
    && mkdir BonDriver_LinuxPTX/ \
    && cd BonDriver_LinuxPTX/ \
    && apt-get install -y --no-install-recommends curl make g++ \
    && curl --insecure -L https://github.com/nns779/BonDriver_LinuxPTX/tarball/develop \
       | tar -zx --strip-components=1 \
    && make \
    && install -m 644 *.so /usr/local/lib/ \
    && cd ../ \
    \
    # cleanup
    && cd / \
    && rm -r /build/ \
    && apt-get remove -y ca-certificates curl make g++ autoconf automake pkg-config libpcsclite-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && :
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD []
EXPOSE 1192
