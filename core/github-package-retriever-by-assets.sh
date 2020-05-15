#!/bin/bash
set -Eeuo pipefail

readonly owner=$1
readonly repository=$2
readonly package_name_regex=$3
readonly url_json_field_name=$4
readonly package_name=$5

url=$(curl -X GET https://api.github.com/repos/$owner/$repository/releases/latest \
  | jq -r --arg name_regex "$package_name_regex" --arg url_field_name "$url_json_field_name" '.assets | .[] | select(.name | test($name_regex)) | .[$url_field_name]')
wget -O $package_name $url