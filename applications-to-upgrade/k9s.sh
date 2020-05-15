#!/bin/bash
set -Eeuo pipefail

readonly CURRENT_DIR=${1:-$(pwd)/..}
readonly temp_folder=k9s_extr
readonly package_name_regex="^k9s_Linux_x86_64.tar.gz$"
readonly github_owner=derailed
readonly github_repo=k9s
readonly url_json_field_name=browser_download_url

rm -fr $temp_folder
ls | grep -P "$package_name_regex" | xargs -d"\n" rm -fr || true
mkdir $temp_folder
$CURRENT_DIR/core/github-package-retriever-by-assets.sh $github_owner $github_repo $package_name_regex $url_json_field_name
ls | grep -P "$package_name_regex" | xargs cat - | tar zxf - -C "$temp_folder/"
sudo mv -f "$temp_folder/k9s" /usr/bin/k9s
rm -fr $temp_folder
ls | grep -P "$package_name_regex" | xargs -d"\n" rm -fr || true
