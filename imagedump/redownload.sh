#!/bin/sh

searchnames="names-only.log"
imagedb="images.json"

while read -r line; do
grep "$line" $imagedb >> missing.json
done <$searchnames
