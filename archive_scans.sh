#!/bin/bash

SCAN_DIR=/run/media/Yc6hR2VEpBdiFT/D513-FB22/EPSCAN/001
SCAN_DIR=/tmp/tmp.RhHPE8diZb

if [ -d ${SCAN_DIR} ]
then
    if [ ! -d ${HOME}/temp/scans ]
    then
        mkdir --parents ${HOME}/temp/scans
    fi
    for FILE in ${SCAN_DIR}/*.JPG
    do
        echo BEGIN ${FILE}
        while [ -f ${FILE} ] && [[ $(lsof | grep ${FILE}) ]]
        do
            echo SLEEP A ${FILE}
            sleep 1s
        done
        if [ -f ${FILE} ] && ! [[ $(lsof | grep ${FILE}) ]]
        then
            (
                flock --exclusive 9
                TEMPFILE=$(mktemp /tmp/$(basename ${FILE}).XXXXXXXXXXXXXXX.PDF)
                NEWFILE=$(mktemp ${HOME}/temp/scans/$(basename ${FILE}).XXXXXXXXXXXXXX.PDF)
                echo ${FILE} convert ${NEWFILE}
                convert ${FILE} ${TEMPFILE}
                mv ${TEMPFILE} ${NEWFILE}
                rm ${FILE}
            ) 9> ${FILE}.lock
            rm ${FILE}.lock
        fi
    done
#    umount ${SCAN_DIR}
fi
