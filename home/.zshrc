# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration


#### PATH ####

# Base path... I added ~/.bin to the beginning so scripts in my home folder's .bin directory override other stuff.
PATH="$HOME/.bin:/usr/local/sbin:/usr/local/bin:/usr/bin"
# Android stuff
PATH="$PATH:/opt/android-sdk/tools:/usr/share/java/gradle/bin:/home/forkk/Programs/android-studio/sdk/platform-tools/:/home/forkk/Programs/android-studio/sdk/platform-tools/"
# export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
# Vim is the best editor.
export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# SSH key path
export SSH_KEY_PATH="~/.ssh/rsa_id"


# Go is best language.
# Set $GOPATH
GOPATH=$HOME/go
# Add $GOPATH/bin to the path
PATH="$PATH:$GOPATH/bin"


# Start SSH agent. My servers don't have my SSH keys, so don't do this on there.
if [[ $HOST != "forkknet-webserver" ]]; then
	eval $(keychain --eval --agents ssh -Q --quiet id_rsa)
fi

# Aliases... There's so many that they get their own file...
source ~/.zsh_aliases

# Run configs local to the computer this file is installed on.
# .zsh_local won't be synced across computers with my other dotfiles.
if [ -f ~/.zsh_local ]; then
	source ~/.zsh_local
fi

# Use airline's promptline prompt.
. ~/.prompt

