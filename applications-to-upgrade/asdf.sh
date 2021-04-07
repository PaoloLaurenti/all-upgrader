#!/bin/bash
set -Eeuo pipefail

source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$DIR/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
readonly CURRENT_DIR="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"

if command -v asdf &>/dev/null; then
  # UPDATE INSTALLATION
  asdf update
else
  # FIRST INSTALLATION
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
  echo '' >> ~/.zshrc 
  echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc 
  echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc 
  cd $CURRENT_DIR
fi
