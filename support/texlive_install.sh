#!/usr/bin/env sh

# Originally from https://github.com/latex3/latex3

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../support/texlive.profile

  cd ..
fi

mkdir /tmp/texlive/texmf-local/tex/latex/iodhbwm
cp . /tmp/texlive/texmf-local/tex/latex/iodhbwm

# Just including texlua so the cache check above works
# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex

## Install package to install packages automatically
tlmgr install texliveonfly

# Install babel languages manually, texliveonfly does't understand the babel error message
tlmgr install collection-langeuropean

# Common fonts with hard to debug errors if not found
tlmgr install collection-fontsrecommended

# Then you can add one package per line in the texlive_packages file
# We need to change the working directory before including a file
cd "$(dirname "${BASH_SOURCE[0]}")"
tlmgr install $(cat texlive.packages)
cd ..
  
texhash

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
