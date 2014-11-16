#!/bin/bash

SCAN_DIR=/run/media/Yc6hR2VEpBdiFT/D513-FB22/EPSCAN/001

if [ -d ${SCAN_DIR} ]
then
    if [ ! -d ${HOME}/temp/scans ]
    then
        mkdir --parents ${HOME}/temp/scans
    fi
    for FILE in ${SCAN_DIR}/*.JPG
    do
        while [ -f ${FILE} ] && [[ $(lsof | grep ${FILE}) ]]
        do
            sleep 1s
        done
        if [ -f ${FILE} ] && ! [[ $(lsof | grep ${FILE}) ]]
        then
            (
                NEWFILE=$(mktemp ${HOME}/temp/scans/$(basename ${FILE}).XXXXXXXXXXXXXX.PDF)
                flock --exclusive 9
                convert ${FILE} ${NEWFILE}
                rm ${FILE}
            ) 9> ${FILE}.lock
            rm ${FILE}.lock
        fi
    done
    sleep 1s
fi
