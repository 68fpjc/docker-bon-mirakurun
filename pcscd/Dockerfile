ARG DEBIAN_TAG
FROM debian:${DEBIAN_TAG}

RUN : \
    && set -x \
    && apt-get update \
    \
    # pcscd
    && apt-get install -y --no-install-recommends pcscd \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    \
    && :

ENTRYPOINT ["pcscd", "--foreground"]
CMD []
