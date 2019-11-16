#!/bin/bash

cd /var/lib/BonDriverProxy_Linux/
for BONCONF in config.in/*.so.conf ; do
  cp ${BONCONF} .
  BONCLIENT=${BONCONF##*/}
  BONCLIENT=${BONCLIENT%.*}
  cp /usr/local/lib/BonDriver_Proxy.so ${BONCLIENT}
done
cd ..

cd /usr/local/lib/node_modules/mirakurun/
for CONF in channels tuners server ; do
  [ ! -s /usr/local/etc/mirakurun/${CONF}.yml ] && cat config/${CONF}.yml > /usr/local/etc/mirakurun/${CONF}.yml
done
exec pm2 --no-daemon start processes.json
