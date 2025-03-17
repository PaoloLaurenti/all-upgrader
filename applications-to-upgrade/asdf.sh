#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

# if command -v asdf &>/dev/null; then
#   # UPDATE INSTALLATION
#   cd ~/.asdf
#   git checkout "$(git describe --abbrev=0 --tags)"
#   cd $CURRENT_DIR
# else
#   # FIRST INSTALLATION
#   git clone https://github.com/asdf-vm/asdf.git ~/.asdf
#   cd ~/.asdf
#   git checkout "$(git describe --abbrev=0 --tags)"
#   echo '' >> ~/.zshrc 
#   echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc 
#   echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc 
#   cd $CURRENT_DIR
# fi

readonly temp_folder="asdf_temp"
readonly extr_folder="asdf_extr"
readonly package_name="asdf.tar.gz"
readonly package_name_regex="^asdf-v\d+\.\d+.\d+-linux-amd64.tar.gz$"
readonly github_owner="asdf-vm"
readonly github_repo="asdf"
readonly url_json_field_name="browser_download_url"
readonly destination_path="$HOME/tools/asdf"

temp_folder_path="$CURRENT_DIR/$temp_folder"
extr_folder_path="$temp_folder_path/$extr_folder"
package_name_path="$temp_folder_path/$package_name"

rm -fr $temp_folder_path
mkdir -p $temp_folder_path
mkdir -p $extr_folder_path
mkdir -p $destination_path

$CURRENT_DIR/../core/github-package-retriever-by-assets.sh $github_owner $github_repo $package_name_regex $url_json_field_name $package_name_path
tar zxf $package_name_path -C "$extr_folder_path/"
cp "$extr_folder_path/asdf" $destination_path

rm -fr $temp_folder_path
