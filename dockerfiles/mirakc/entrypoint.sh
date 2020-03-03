#!/bin/bash

cd /var/lib/BonDriverProxy_Linux/
for BONCONF in config.in/*.so.conf ; do
  cp ${BONCONF} .
  BONCLIENT=${BONCONF##*/}
  BONCLIENT=${BONCLIENT%.*}
  cp /usr/local/lib/BonDriver_Proxy.so ${BONCLIENT}
done
cd ..

exec mirakc