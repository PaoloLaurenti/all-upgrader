#!/bin/bash
set -Eeuo pipefail

readonly temp_folder=k9s_extr
readonly package_name=k9s_Linux_x86_64.tar.gz

rm -fr $temp_folder
rm -fr $package_name
mkdir $temp_folder
core/github-package-retriever.sh derailed k9s $package_name
tar zxf $package_name -C "$temp_folder/"
sudo mv -f "$temp_folder/k9s" /usr/bin/k9s
rm -fr $temp_folder
rm -fr $package_name
