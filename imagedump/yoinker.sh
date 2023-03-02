#!/bin/bash

jq -r 'to_entries|map("\(.key) \(.value|tostring)")|.[]' $1 | while read key value; do
  val="${value}"
  pre="${key}"
  echo "${val}"
  echo "${pre}"
  googleimagesdownload -n --keywords "${val}" --limit 1 --prefix "${pre}"
done
