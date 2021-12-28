#!/bin/sh

set -e

echo "Running Donovan's Development Environment Configuration Tool..."

RBENV_ROOT=$(rbenv root)
if [[ -n "${RBENV_ROOT}" ]]; then
  echo "Installing ruby-build"
  [[ ! -d ${RBENV_ROOT}/plugins ]] && mkdir -p ${RBENV_ROOT}/plugins
  [[ ! -d ${RBENV_ROOT}/plugins/ruby-build ]] && git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
  git -C ${RBENV_ROOT}/plugins/ruby-build pull
fi

if [[ ! -f ~/.gitconfig ]]; then
  echo "Installing new .gitconfig"
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/git/config -o ~/.gitconfig
fi

if [[ -d ~/.oh-my-zsh ]]; then
  if [[ -f ~/.zshrc ]]; then
    echo "Backing up existing .zshrc file"
    mv ~/.zshrc ~/.zshrc.backup
  fi

  echo "Installing new .zshrc"
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/zsh/config -o ~/.zshrc
fi

echo "Complete."
