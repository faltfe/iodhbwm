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

# Required to build plain and LaTeX formats:
# TeX90 plain for unpacking, pdfLaTeX, LuaLaTeX and XeTeX for tests
tlmgr install cm etex knuth-lib latex-bin tex tex-ini-files unicode-data \
  xetex
  
# Additional requirements for (u)pLaTeX, done with no dependencies to
# avoid large font payloads
tlmgr install --no-depends babel ptex uptex ptex-base uptex-base ptex-fonts \
  uptex-fonts platex uplatex

# Assuming a 'basic' font set up, metafont is required to avoid
# warnings with some packages and errors with others
tlmgr install metafont mfware collection-fontsrecommended


# Set up graphics: nowadays split over a few places and requiring
# HO's bundle
tlmgr install graphics graphics-cfg graphics-def oberdiek

# Other contrib packages: done as a block to avoid multiple calls to tlmgr
# texlive-latex-base is needed to run pdflatex
tlmgr install   \
  amsfonts      \
  l3packages    \
  l3kernel      \
  koma-script   \
  etoolbox      \
  xstring       \
  everyhook     \
  svn-prov      \
  needspace     \
  marginnote    \
  glossaries    \
  xkeyval       \
  mfirstuc      \
  textcase      \
  xfor          \
  datatool      \
  substr        \
  fp            \
  xcolor        \
  skdoc         \
  ydoc          \
  babel-german  \
  hyph-utf8     \
  hyphen-german \
  listings      \
  csquotes      \
  caption       \
  paratype sourcecodepro ly1 mweights opensans slantsc \
  microtype enumitem blindtext \
  pgf pgfopts xpatch setspace siunitx mathtools tcolorbox \
  booktabs biblatex biber cleveref \
  environ trimspaces multirow logreq lipsum blindtext
  
texhash

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
