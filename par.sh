#!/bin/bash

WORK_DIR=$(mktemp -d)

TSTAMP=$(date +%Y-%m-%d-%H-%M)

mkdir ${WORK_DIR}/classes

cp ${@}/processdefinition.xml ${WORK_DIR}
cp ${@}/forms.xml ${WORK_DIR}

jar -cf ${@}.${TSTAMP}.par -C ${WORK_DIR} .
