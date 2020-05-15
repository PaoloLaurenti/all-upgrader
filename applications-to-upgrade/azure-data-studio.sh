#!/bin/bash
set -Eeuo pipefail

readonly CURRENT_DIR=${1:-$(pwd)/..}
readonly temp_folder=azure_data_studio_temp
readonly github_owner=microsoft
readonly github_repo=azuredatastudio
readonly json_body_regex='\[linux-deb\]:\s*([^\\"]+)'
readonly package_name="azure_data_studio.deb"

package_name_path="$temp_folder/$package_name"

rm -fr $temp_folder
mkdir $temp_folder
$CURRENT_DIR/core/github-package-retriever-by-body.sh $github_owner $github_repo $json_body_regex $package_name_path
sudo dpkg -i $package_name_path
rm -fr $temp_folder
