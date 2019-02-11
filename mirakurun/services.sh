#!/bin/sh

cd $(cd $(dirname $0); pwd)

[ "${MIRAKURUN_WAITFOR}" ] && ./wait-for-it.sh -t 0 ${MIRAKURUN_WAITFOR}

cd client/
for BONCONF in config.in/*.conf ; do
  cp ${BONCONF} .
  BONCLIENT=${BONCONF##*/}
  BONCLIENT=${BONCLIENT%.*}
  cp ../BonDriver_Proxy.so ${BONCLIENT}
done
cd ..

cd /usr/local/lib/node_modules/mirakurun/
for CONF in channels tuners server ; do
  [ ! -s /usr/local/etc/mirakurun/${CONF}.yml ] && cat config/${CONF}.yml > /usr/local/etc/mirakurun/${CONF}.yml
done
exec pm2 --no-daemon start processes.json
