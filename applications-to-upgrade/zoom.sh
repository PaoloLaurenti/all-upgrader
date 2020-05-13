#!/bin/bash
set -Eeuo pipefail

rm -fr zoom_amd64.deb 
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb
rm -fr zoom_amd64.deb
