#!/bin/sh

searchnames="names-only.log"
recipesdb="recipenames.json"

while read -r line; do
grep "$line" $recipesdb >> missing.json
done <$searchnames
