FROM alpine:3.8

WORKDIR /app/

RUN : \
    && set -x \
    && apk update \
    \
    && mkdir driver/ \
    && mkdir client/ \
    \
    && apk add --no-cache --virtual .build-deps \
         git build-base linux-headers \
    \
    && git clone https://github.com/u-n-k-n-o-w-n/BonDriverProxy_Linux.git tmp \
    && cd tmp/ \
    && BUILD=DEBUG make server driver \
    && mv BonDriverProxy BonDriver_LinuxPT.so BonDriver_LinuxPT.conf BonDriver_Proxy.conf .. \
    && cd .. \
    && rm -rf tmp \
    \
    && apk del --purge .build-deps \
    \
    && apk add --no-cache libstdc++ libgcc \
    && :

COPY services.sh .
CMD ["./services.sh"]

EXPOSE 1192
