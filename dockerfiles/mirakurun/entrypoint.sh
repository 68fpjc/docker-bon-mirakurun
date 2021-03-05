#!/bin/bash

LIBDIR=/var/lib/BonDriverProxy_Linux/
mkdir -p ${LIBDIR}config.in/
cp ${LIBDIR}config.in/*.conf ${LIBDIR} 2> /dev/null
rm ${LIBDIR}*.so 2> /dev/null
for I in $(seq 0 99) ; do
  II=$(printf "%02d" ${I})
  cp /usr/local/lib/BonDriver_Proxy.so ${LIBDIR}BonDriver_Proxy-${II}.so
done

[ -e /opt/bin/ ] || mkdir -p /opt/bin/
if [ ! -e /opt/bin/exec-socat ] ;then
  cat << 'EOF' > /opt/bin/exec-socat
#! /bin/sh

exec socat - tcp-connect:<REMOTE-HOST>:<REMOTE-PORT>
EOF
  chmod +x /opt/bin/exec-socat
fi

cd /app/
exec docker/container-init.sh
