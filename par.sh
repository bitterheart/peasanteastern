#!/bin/bash

WORK_DIR=$(mktemp -d)

TSTAMP=$(date +%Y-%m-%d-%H-%M)

mkdir ${WORK_DIR}/classes

sed -e "s#document#${@}.${TSTAMP}#" -e "w${WORK_DIR}/processdefinition.xml" ${@}/processdefinition.xml
cp ${@}/forms.xml ${WORK_DIR}

jar -cf ${@}.${TSTAMP}.par -C ${WORK_DIR} .
