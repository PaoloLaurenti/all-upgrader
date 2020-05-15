#!/bin/bash
set -Eeuo pipefail

readonly CURRENT_DIR=${1:-$(pwd)/..}
readonly temp_folder=k9s_temp
readonly extr_folder=k9s_extr
readonly package_name="k9s.tar.gz"
readonly package_name_regex="^k9s_Linux_x86_64.tar.gz$"
readonly github_owner=derailed
readonly github_repo=k9s
readonly url_json_field_name=browser_download_url

extr_folder_path="$temp_folder/$extr_folder"
package_name_path="$temp_folder/$package_name"

rm -fr $temp_folder
mkdir $temp_folder

mkdir -p $extr_folder_path
$CURRENT_DIR/core/github-package-retriever-by-assets.sh $github_owner $github_repo $package_name_regex $url_json_field_name $package_name_path
tar zxf $package_name_path -C "$extr_folder_path/"
sudo mv -f "$extr_folder_path/k9s" /usr/bin/k9s

rm -fr $temp_folder