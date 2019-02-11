#!/bin/sh

cd $(cd $(dirname $0); pwd)

MYADDR=$(hostname -i)

rm driver/* client/* > /dev/null 2>&1
for I in $(seq 0 99) ; do
  II=${I}
  [ ${#I} -eq 1 ] && II=0${II}
  CLIENTLIB=driver/BonDriver_LinuxPT-${II}.so
  cp BonDriver_LinuxPT.so ${CLIENTLIB}
  cat BonDriver_LinuxPT.conf | sed -E "s|^#DEVICE=.+|#DEVICE=/dev/pt3video${I}|" > ${CLIENTLIB}.conf
  #for J in $(echo ${BONDRIVERPROXY_USELNB} | tr ',' ' ') ; do
  for J in ${BONDRIVERPROXY_USELNB//,/ } ; do
    if [ "${J}" == "${I}" ] ; then
      sed -i -E "s|^#USELNB=.+|#USELNB=1|" ${CLIENTLIB}.conf
      break
    fi
  done
  cat BonDriver_Proxy.conf | sed -E "s|^(BONDRIVER=).+|\1${PWD}/${CLIENTLIB}|" | sed "s|192.168.0.100|${MYADDR}|g" > client/BonDriver_Proxy-${II}.so.conf
done

exec ./BonDriverProxy ${MYADDR} 1192 2>&1 | while read LINE ; do echo "$(date -Iseconds): ${LINE}" ; done
