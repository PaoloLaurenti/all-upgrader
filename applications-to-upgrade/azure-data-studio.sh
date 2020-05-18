#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"

readonly temp_folder=azure_data_studio_temp
readonly github_owner=microsoft
readonly github_repo=azuredatastudio
readonly json_body_regex='\[linux-deb\]:\s*([^\\"]+)'
readonly package_name="azure_data_studio.deb"

temp_folder_path="$CURRENT_DIR/$temp_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path

$CURRENT_DIR/../core/github-package-retriever-by-body.sh $github_owner $github_repo $json_body_regex $package_name_path
sudo apt install $package_name_path

rm -fr $temp_folder_path
