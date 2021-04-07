#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

readonly temp_folder=aws_cli_temp
readonly package_name="awscliv2.zip"

temp_folder_path="$CURRENT_DIR/$temp_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o $package_name_path
unzip $package_name_path -d $temp_folder_path
chmod +x $temp_folder_path/aws/install

if command -v aws &>/dev/null; then
  # UPDATE INSTALLATION
  sudo $temp_folder_path/aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
else
  # FIRST INSTALLATION
  sudo $temp_folder_path/aws/install
fi

rm -fr $temp_folder_path
