#!/bin/bash
set -Eeuo pipefail

trap "exit" INT TERM ERR
trap "kill 0" EXIT

# sudo apt-get clean \
# && sudo apt-get update \
# && sudo apt-get dist-upgrade \
# && sudo apt-get autoremove 

# sudo snap refresh 

applications=$(ls -d applications-to-upgrade/*)
for app in $applications
do
  echo "======================================================"
  echo "Update $app"
  ./$app
  echo "======================================================"
  echo ""
done

wait