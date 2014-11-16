#!/bin/bash

for I in $(seq 1 60)
do
    if [ ! -d ${HOME}/temp/printouts ]
    then
        mkdir --parents ${HOME}/temp/printouts
    fi
    for FILE in ${HOME}/*.pdf
    do
        while [ -f ${FILE} ] && [[ $(lsof | grep ${FILE}) ]]
        do
            sleep 1s
        done
        if [ -f ${FILE} ] && ! [[ $(lsof | grep ${FILE}) ]]
        then
            (
                NEWFILE=$(mktemp ${HOME}/temp/printouts/$(basename ${FILE}).XXXXXXXXXXXXXX.pdf)
                flock --exclusive 9
                mv ${FILE} ${NEWFILE}
            ) 9> ${FILE}.lock
            rm ${FILE}.lock
        fi
    done
    sleep 1s
done
