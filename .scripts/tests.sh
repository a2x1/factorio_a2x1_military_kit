#!/bin/bash

DATE=$(date +%Y.%m.%d.)
NAME=`jq .name info.json -r`
VERSION=`jq .version info.json -r`

echo ""
echo "Searching Release Version in mods.factorio.com"
echo ""

curl -s https://mods.factorio.com/api/mods/${NAME}/full | jq -e ".releases[]? | select(.version == \"${VERSION}\")"
STATUS_CODE=$?

if [[ $STATUS_CODE -ne 4 ]]; then
  echo ""
  echo "Release already exists, skipping"
  echo ""
  exit 1
else
  echo "Factorio MOD Release ${VERSION} not found"
fi

echo ""
echo "Searching changelog.txt for Release Version"
echo ""
# if ! grep "$VERSION[[:cntrl:]]*$" changelog.txt > /dev/null; then
if ! grep "$VERSION[[:cntrl:]]*$" changelog.txt; then
  echo "ERROR: Current version ${VERSION} not found in 'changelog.txt'. Please add ingame changelog for current version." 1>&2
  echo "See https://forums.factorio.com/viewtopic.php?f=25&t=67140 for mor information." 1>&2
  echo ""
  exit 1
fi

echo ""
echo "Searching changelog.txt for Release Date"
echo ""
# if ! grep "$DATE" changelog.txt > /dev/null; then
if ! grep "$DATE" changelog.txt; then
  echo ""
  echo "ERROR: Current date ${DATE} not found in 'changelog.txt'. Please add ingame changelog with current date." 1>&2
  echo "See https://forums.factorio.com/viewtopic.php?f=25&t=67140 for mor information." 1>&2
  echo ""
  exit 1
fi

echo ""
echo "ALL seems OK"
echo ""
