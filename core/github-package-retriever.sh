#!/bin/bash
set -Eeuo pipefail

readonly owner=$1
readonly repository=$2
readonly package_name=$3

url=$(curl -X GET https://api.github.com/repos/$owner/$repository/releases/latest \
  | jq -r --arg name "$package_name" '.assets | .[] | select(.name | contains($name)) | .browser_download_url')

wget "$url"