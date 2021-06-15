#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"

readonly temp_folder=postman_temp
readonly extr_folder=postman_extr
readonly package_name="postman.tar.gz"
readonly dest_folder_path="/opt/postman"

temp_folder_path="$CURRENT_DIR/$temp_folder"
extr_folder_path="$temp_folder_path/$extr_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path
mkdir -p $extr_folder_path

wget -O $package_name_path https://dl.pstmn.io/download/latest/linux64
tar zxf $package_name_path -C "$extr_folder_path/"
sudo mkdir -p $dest_folder_path
sudo rm -fr "$dest_folder_path/app"
sudo mv -f "$extr_folder_path/Postman/app" $dest_folder_path
sudo rm -fr /usr/local/bin/postman && sudo ln -sv "$dest_folder_path/app/Postman" /usr/local/bin/postman

rm -fr $temp_folder_path