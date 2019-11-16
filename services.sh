#!/bin/sh
CHANNELS=$(ls -l /dev/px4video* | wc -l)
if [ ${CHANNELS} != "8" ] ; then
  sudo usb_modeswitch -v 0x05e3 -p 0608 --reset-usb
  sleep 2
fi
exec docker-compose -f docker-compose.bon-mirakc.yml up -d
