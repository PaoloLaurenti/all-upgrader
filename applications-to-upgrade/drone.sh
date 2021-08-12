#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

readonly temp_folder=drone_temp
readonly package_name="drone.tar"

temp_folder_path="$CURRENT_DIR/$temp_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path

curl -L "https://github.com/drone/drone-cli/releases/latest/download/drone_linux_amd64.tar.gz" -o $package_name_path
sudo install -t /usr/local/bin $package_name_path

rm -fr $temp_folder_path
