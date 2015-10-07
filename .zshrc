# Lines configured by zsh-newuser-install
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
ZSH_THEME="pure"
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/xinjiang/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


fpath=( "$HOME/.zfunctions" $fpath )

#autoload -U promptinit && promptinit
#prompt pure


source ~/code/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo declared above.
antigen bundles <<EOBUNDLES
git
git-flow
git-extras
osx
lein
pip
sharat87/autoenv
nvm
# Guess what to install when running an unknown command.
command-not-found
# Helper for extracting different types of archives.
extract
# atom editor
atom
# homebrew something
brew
# Tracks your most used directories, based on 'frecency'. 
z
# nicoulaj's moar completion files for zsh
zsh-users/zsh-completions src
# ZSH port of Fish shell's history search feature.
zsh-users/zsh-history-substring-search
# Syntax highlighting bundle.
zsh-users/zsh-syntax-highlighting
# colors for all files!
trapd00r/zsh-syntax-highlighting-filetypes
EOBUNDLES

# dont set a theme, because pure does it all
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure



# Tell antigen that you're done.
antigen apply

# Load default dotfiles
source ~/.bash_profile


# Automatically list directory contents on `cd`.
auto-ls () { ls; }
chpwd_functions=( auto-ls $chpwd_functions )
# Setup zsh-autosuggestions
source /Users/xinjiang/.zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically
zle-line-init() {
    zle autosuggest-start
}

zle -N zle-line-init

# use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
# zsh-autosuggestions is designed to be unobtrusive)
bindkey '^T' autosuggest-toggle

# added by travis gem
[ -f /Users/xinjiang/.travis/travis.sh ] && source /Users/xinjiang/.travis/travis.sh

# powerline shell
function powerline_precmd() {
      PS1="$(~/powerline-shell.py $? --shell zsh 2> /dev/null)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
