#!/bin/bash
set -Eeuo pipefail

readonly temp_folder=wmware_temp
readonly package_name="getplayer-linux"

rm -fr $temp_folder
mkdir $temp_folder

package_name_path="$temp_folder/$package_name"

wget -O $package_name_path --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0" https://www.vmware.com/go/getplayer-linux
chmod +x $package_name_path 
sudo "./$package_name_path"

rm -fr $temp_folder