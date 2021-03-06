#! /bin/bash

pushd "$(dirname $0)" > /dev/null

[ $# -eq 1 ] || exit 1

# Mirakurun
pushd data/mirakurun/ > /dev/null
FILE=config/channels.yml
[ -f ${FILE} ] || cp config/sample.channels.yml ${FILE} && echo created ${PWD}/${FILE}

FILE=config/tuners.yml
[ -f ${FILE} ] || cp config/sample.tuners.yml ${FILE} && echo created ${PWD}/${FILE}

FILE=opt/bin/exec-socat
mkdir -p opt/bin/
if [ ! -f ${FILE} ] ;then
  cat << EOF > ${FILE}
#! /bin/sh

exec socat - $1
EOF
  chmod +x ${FILE}
  echo created ${PWD}/${FILE}
fi
popd  > /dev/null

# mirakc
pushd data/mirakc/ > /dev/null
FILE=config.yml
if [ ! -f ${FILE} ] ;then
  cat sample.config.yml | sed "s|<REMOTE-HOST>:<REMOTE-PORT>|$1|" > ${FILE}
  echo created ${PWD}/${FILE}
fi
popd  > /dev/null

popd  > /dev/null
