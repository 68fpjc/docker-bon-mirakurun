#!/bin/bash

LIBDIR=/var/lib/BonDriverProxy_Linux/
mkdir -p ${LIBDIR}config.in/
cp ${LIBDIR}config.in/*.conf ${LIBDIR} 2> /dev/null
rm ${LIBDIR}*.so 2> /dev/null
for I in $(seq 0 99) ; do
  II=$(printf "%02d" ${I})
  cp /usr/local/lib/BonDriver_Proxy.so ${LIBDIR}BonDriver_Proxy-${II}.so
done

cd /app/
exec docker/container-init.sh
