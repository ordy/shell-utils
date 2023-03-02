#!/bin/bash

jq -r 'to_entries|map("\(.key) \(.value|tostring)")|.[]' $1 | while read key value; do
  val="${value}"
  pre="${key}"
  echo "${val}"
  echo "${pre}"
  ./image_downloader.py -n --keywords "${val}" --limit 1 --prefix "${pre}"
done
