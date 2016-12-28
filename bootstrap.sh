#!/bin/bash -ex

# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1

sudo -v
##
## new machine setup.
##

xcode-select --install

# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#
# install all the things
sh brew
sh brew-cask

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
git clone git://github.com/jamiew/git-friendly.git ~/code/git-friendly

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# github.com/rupa/z   - oh how i love you
git clone https://github.com/rupa/z.git ~/code/z
chmod +x ~/code/z/z.sh

# github.com/thebitguru/play-button-itunes-patch
# disable itunes opening on media keys
# git clone https://github.com/thebitguru/play-button-itunes-patch ~/code/play-button-itunes-patch

# change to bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
sudo echo $BASHPATH >> /etc/shells
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION # should be 4.x not the old 3.2.X
# Later, confirm iterm settings aren't conflicting.
# go read mathias, paulmillr, gf3, alraa's dotfiles to see what to update with.
# set up osx defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
#sh macos

# Install oh-my-zsh now
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
# Install antigen
git clone https://github.com/zsh-users/antigen.git ~/code/antigen
# Install Autosuggestion
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh-autosuggestions

# install iOS App Development Tools
# avoid error in el capitan Ref http://stackoverflow.com/questions/30812777/cannot-install-cocoa-pods-after-uninstalling-results-in-error
sudo gem install cocoapods
sudo gem install fastlane
sudo gem install xcpretty

# Install Tools for Automation Deployment
sudo easy_install pip

# Front End Development Toolkit
npm install -g yarn
npm install -g gulp-cli
npm install -g jshint

# symlinks!
#   put/move git credentials into ~/.gitconfig.local
#   http://stackoverflow.com/a/13615531/89484
sh symlink-setup.sh

