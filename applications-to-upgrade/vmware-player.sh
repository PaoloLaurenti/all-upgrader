#!/bin/bash
set -Eeuo pipefail

rm -fr getplayer-linux 
wget --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0" https://www.vmware.com/go/getplayer-linux
chmod +x getplayer-linux
sudo ./getplayer-linux
rm -fr getplayer-linux
