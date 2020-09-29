#!/bin/sh

for extension in $@
do
    ${CODE_SERVER_BIN} --install-extension "$extension"
done
