#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

readonly temp_folder="gitleaks_temp"
readonly extr_folder="gitleaks_extr"
readonly package_name="gitleaks.tar.gz"
readonly package_name_regex="^gitleaks.\d+\.\d+.\d+.linux_x64\.tar\.gz$"
readonly github_owner="gitleaks"
readonly github_repo="gitleaks"
readonly url_json_field_name="browser_download_url"
readonly destination_path="/usr/local/bin/"

temp_folder_path="$CURRENT_DIR/$temp_folder"
extr_folder_path="$temp_folder_path/$extr_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path
mkdir -p $extr_folder_path
mkdir -p $destination_path

$CURRENT_DIR/../core/github-package-retriever-by-assets.sh $github_owner $github_repo $package_name_regex $url_json_field_name $package_name_path
tar zxf $package_name_path -C "$extr_folder_path/"
sudo mv -f "$extr_folder_path/gitleaks" /usr/local/bin/gitleaks

rm -fr $temp_folder_path
