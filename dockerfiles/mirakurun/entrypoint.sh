#!/bin/bash

cd /var/lib/BonDriverProxy_Linux/
for BONCONF in config.in/*.so.conf ; do
  cp ${BONCONF} .
  BONCLIENT=${BONCONF##*/}
  BONCLIENT=${BONCLIENT%.*}
  cp /usr/local/lib/BonDriver_Proxy.so ${BONCLIENT}
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
