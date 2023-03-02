#!/bin/sh

jq -r 'to_entries|map("\(.key)")|.[]' $1 | while read key; do
if [ -e ./imgdownload/${key}.* ]; then
  echo "$key exists"
else
  echo $key >> missing2.log
fi
done
