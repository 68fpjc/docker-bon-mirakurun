ARG DEBIAN_TAG
FROM debian:${DEBIAN_TAG}
RUN : \
    && set -x \
    && apt-get update \
    \
    && apt-get install -y --no-install-recommends pcscd \
    \
    # cleanup
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && :
ENTRYPOINT ["pcscd", "--foreground"]
CMD []