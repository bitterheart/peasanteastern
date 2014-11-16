#!/bin/bash

WORK_DIR=$(mktemp -d)

mkdir ${WORK_DIR}/classes

javac -classpath jbpm-jpdl-3.2.3.jar:${HOME}/openkm-6.3.0-community.backup/tomcat/webapps/OpenKM/WEB-INF/classes -d ${WORK_DIR}/classes ${@}/src/peasanteastern/*.java

cp ${@}/processdefinition.xml ${WORK_DIR}
cp ${@}/forms.xml ${WORK_DIR}

jar -cf ${@}.par -C ${WORK_DIR} .
