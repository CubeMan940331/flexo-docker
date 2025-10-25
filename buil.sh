#!/bin/bash
mkdir -p src
if [ ! -e "src/flexo-master.zip" ];then
    wget -O src/flexo-master.zip https://github.com/nroi/flexo/archive/refs/heads/master.zip
fi
if [ ! -e "src/scruffy-main.zip" ]; then
    wget -O src/scruffy-main.zip https://github.com/nroi/scruffy/archive/refs/heads/main.zip
fi

docker build . -t flexo-server
