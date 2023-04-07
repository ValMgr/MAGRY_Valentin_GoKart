#!/bin/bash

todorgxp="@todo|@TODO"

if [ $? -eq 1 ]; then
  echo "✅"
  exit 0
else
  find lib -type f -print | xargs grep -HiRE $todorgxp
  find packages -type f -print | xargs grep -HiRE $todorgxp
  echo
  echo "❌"
  exit 1
fi