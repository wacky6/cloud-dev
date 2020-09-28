#!/usr/bin/env zsh

exec $CODE_SERVER_BIN --auth none --bind-addr=$(hostname -i):9000 ${WORKDIR}