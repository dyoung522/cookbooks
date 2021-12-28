#!/bin/sh

set -e

echo "Running Donovan's Vagrant development environment configuration tool..."

echo "Copying .gitconfig"
curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/git/config -o ~/.gitconfig

echo "Copying .zshrc"
curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/zsh/config -o ~/.zshrc
