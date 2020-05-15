#!/bin/bash
set -Eeuo pipefail

readonly temp_folder=zoom_temp
readonly package_name="zoom.deb"

rm -fr $temp_folder
mkdir $temp_folder

package_name_path="$temp_folder/$package_name"

wget -O $package_name_path https://zoom.us/client/latest/zoom_amd64.deb
echo $package_name_path
sudo dpkg -i $package_name_path

rm -fr $temp_folder
