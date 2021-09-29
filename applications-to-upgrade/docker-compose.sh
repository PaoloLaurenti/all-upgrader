#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$( cd -P "$( dirname "$source" )" >/dev/null 2>&1 && pwd )"

readonly temp_folder=docker_compose_temp
readonly package_name="docker-compose"
readonly package_name_regex="^docker-compose-linux-amd64$"
readonly github_owner=docker
readonly github_repo=compose
readonly url_json_field_name=browser_download_url

temp_folder_path="$CURRENT_DIR/$temp_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path

$CURRENT_DIR/../core/github-package-retriever-by-assets.sh $github_owner $github_repo $package_name_regex $url_json_field_name $package_name_path
chmod +x $package_name_path
sudo mv -f "$temp_folder_path/$package_name" /usr/local/bin/$package_name

rm -fr $temp_folder_path