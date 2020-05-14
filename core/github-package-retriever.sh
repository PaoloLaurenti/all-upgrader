#!/bin/bash
set -Eeuo pipefail

readonly owner=$1
readonly repository=$2
readonly package_name_regex=$3

url=$(curl -X GET https://api.github.com/repos/$owner/$repository/releases/latest \
  | jq -r --arg name_regex "$package_name_regex" '.assets | .[] | select(.name | test($name_regex)) | .browser_download_url')

wget "$url"