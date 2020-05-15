#!/bin/bash
set -Eeuo pipefail

readonly owner=$1
readonly repository=$2
readonly body_regex=$3
readonly package_name=$4

body=$(curl -X GET https://api.github.com/repos/$owner/$repository/releases/latest | jq -r '.body')
[[ $body =~ $body_regex ]]
wget -O $package_name "${BASH_REMATCH[1]}" 

