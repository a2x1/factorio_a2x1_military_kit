#!/bin/bash

DATE=$(date +%Y.%m.%d.)
NAME=`jq .name info.json -r`
VERSION=`jq .version info.json -r`

TMP_DIR=.${NAME}_${VERSION}
RELEASE_FILE_ZIP=${NAME}_${VERSION}.zip

echo ""

mkdir -p ${TMP_DIR}/${NAME}

cp -r locale ${TMP_DIR}/${NAME}
cp -r resources ${TMP_DIR}/${NAME}
cp -r LICENSE ${TMP_DIR}/${NAME}
cp -r *.json ${TMP_DIR}/${NAME}
cp -r *.lua ${TMP_DIR}/${NAME}
cp -r *.png ${TMP_DIR}/${NAME}
cp -r *.txt ${TMP_DIR}/${NAME}
cp -r *.md ${TMP_DIR}/${NAME}

rm -rf ${RELEASE_FILE_ZIP} || true

(cd ${TMP_DIR} && zip -r ../${RELEASE_FILE_ZIP} .)

rm -rf ${TMP_DIR}

echo ""

stat ${RELEASE_FILE_ZIP}

echo ""
