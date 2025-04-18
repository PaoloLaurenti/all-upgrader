#!/bin/bash
set -Eeo pipefail

trap "exit" INT TERM ERR
trap "kill 0" EXIT

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"

sudo rm -rf /var/lib/apt/lists/* \
&& sudo apt-get clean \
&& sudo apt-get update \
&& sudo apt-get dist-upgrade -y \
&& sudo apt-get autoremove -y

sudo killall snap-store & sudo snap refresh

applications=$(ls -d $CURRENT_DIR/applications-to-upgrade/*.sh)
for app in $applications
do
  echo "======================================================"
  echo "Update $app"
  echo ""
  echo ""
  $app $CURRENT_DIR
  echo "======================================================"
  echo ""
done

wait
