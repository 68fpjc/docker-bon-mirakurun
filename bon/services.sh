#!/bin/bash

cd /var/lib/BonDriverProxy_Linux/
for I in $(seq 0 99) ; do
  II=$(printf "%02d" ${I})
  DRIVERLIB=BonDriver_LinuxPT-${II}.so
  cp /usr/local/lib/BonDriver_LinuxPT.so ${DRIVERLIB}
  cat /usr/local/lib/BonDriver_LinuxPT.conf | sed -E "s|^#DEVICE=.+|#DEVICE=/dev/pt3video${I}|" > ${DRIVERLIB}.conf
  DRIVERLIB_DVB=BonDriver_DVB-${II}.so
  cp /usr/local/lib/BonDriver_DVB.so ${DRIVERLIB_DVB}
  cat /usr/local/lib/BonDriver_DVB.conf | sed -E "s|^#ADAPTER_NO=.+|#ADAPTER_NO=${I}|" > ${DRIVERLIB_DVB}.conf
  for J in ${BONDRIVERPROXY_USELNB//,/ } ; do
    if [ "$(printf "%d" ${J})" == "${I}" ] ; then
      sed -i -E "s|^#USELNB=.+|#USELNB=1|" ${DRIVERLIB}.conf
      sed -i -E "s|^#USELNB=.+|#USELNB=1|" ${DRIVERLIB_DVB}.conf
      break
    fi
  done
done

exec BonDriverProxy $(hostname -i) 1192 2>&1 | while read LINE ; do echo "$(date -Iseconds): ${LINE}" ; done
