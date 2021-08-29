#!/bin/bash

LIBDIR=/var/lib/BonDriverProxy_Linux/
mkdir -p ${LIBDIR}config.in/
cp ${LIBDIR}config.in/*.conf ${LIBDIR}config.in/*.ini ${LIBDIR} 2> /dev/null
rm ${LIBDIR}*.so 2> /dev/null
for I in $(seq 0 19) ; do
  II=$(printf "%02d" ${I})
  cp /usr/local/lib/BonDriver_LinuxPT.so ${LIBDIR}BonDriver_LinuxPT-${II}.so
  cp /usr/local/lib/BonDriver_DVB.so ${LIBDIR}BonDriver_DVB-${II}.so
  cp /usr/local/lib/BonDriver_LinuxPTX.so ${LIBDIR}BonDriver_LinuxPTX-${II}.so
done

exec BonDriverProxy $(hostname -i) 1192 $@ 2>&1 | while read LINE ; do echo "$(date -Iseconds): ${LINE}" ; done
