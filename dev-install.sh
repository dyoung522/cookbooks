#!env bash

set -e

echo "Running Donovan's Development Environment Configuration Tool..."

if [[ ! -d ~/.rbenv ]]; then
  echo "Installing rbenv"
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  eval "$(rbenv init -)"
fi

RBENV_ROOT=$(rbenv root)
if [[ -n "${RBENV_ROOT}" ]]; then
  echo "Installing ruby-build"
  [[ ! -d ${RBENV_ROOT}/plugins ]] && mkdir -p ${RBENV_ROOT}/plugins
  [[ ! -d ${RBENV_ROOT}/plugins/ruby-build ]] && git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
  git -C ${RBENV_ROOT}/plugins/ruby-build pull

  RUBY_VERSION=$(rbenv install --list 2>/dev/null | grep -P "^\d+" | tail -1)
  echo "Installing ruby v${RUBY_VERSION}"
  if [[ -n "${RUBY_VERSION}" ]]; then
    rbenv install --skip-existing $RUBY_VERSION
    rbenv global $RUBY_VERSION
  fi

  echo "Installing bundler"
  gem install bundler

  echo "installing rubocop"
  gem install rubocop
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/ruby/rubocop.yml -o ~/.rubocop.yml
fi

if [[ ! -f ~/.gitconfig ]]; then
  echo "Installing new .gitconfig"
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/git/config -o ~/.gitconfig
fi

if [[ ! -f ~/.gitignore ]]; then
  echo "Installing new .gitignore"
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/git/ignore -o ~/.gitignore
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
  if [[ -f ~/.zshrc ]]; then
    echo "Backing up existing .zshrc file"
    mv ~/.zshrc ~/.zshrc.backup
  fi

  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "Installing customized .zshrc"
  curl -fsSL https://raw.githubusercontent.com/dyoung522/cookbooks/main/zsh/config -o ~/.zshrc
fi

echo "Complete."
