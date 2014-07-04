#!/bin/fish

#### PATH ####

# ~/.bin Scripts
set -g fish_user_paths $fish_user_paths $HOME/.bin

# SSH key path
set -g SSH_KEY_PATH "~/.ssh/rsa_id"

# Haskell
set -g fish_user_paths $fish_user_paths $HOME/.cabal/bin/ 

# Go
# Set $GOPATH
set -g GOPATH $HOME/go
# Add $GOPATH/bin to the path
set -g fish_user_paths $fish_user_paths $GOPATH/bin

# Ruby
set -g fish_user_paths $fish_user_paths $HOME/.gem/ruby/2.1.0/bin


#### MISC CONFIG ####

# Preferred editor for local and remote sessions
# Vim is the best editor.
set -g EDITOR 'vim'

# Compilation flags
set -g ARCHFLAGS "-arch x86_64"


#### SSH AGENT ####

# Start SSH agent if keychain is installed.
eval (keychain --eval --agents ssh -Q --quiet id_rsa)


#### TMUXINATOR ####

#source ~/.tmuxinator.fish


#### ALIASES ####


#### LOCAL CONFIGS ####

# Run configs local to the computer this file is installed on.
# .zsh_local won't be synced across computers with my other dotfiles.
if test -f ~/.fish_local; then
	source ~/.fish_local
end

