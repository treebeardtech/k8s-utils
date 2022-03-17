#!/usr/bin/env bash
set -eu -o pipefail
sudo chsh -s /usr/bin/zsh vscode

git clone \
  'https://github.com/zsh-users/zsh-autosuggestions' \
  "${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" \
  || true

git clone \
  'https://github.com/zsh-users/zsh-syntax-highlighting.git' \
  "${ZSH_CUSTOM:-/home/vscode/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" \
  || true

sh -c "FORCE=1 $(curl -fsSL https://starship.rs/install.sh)"