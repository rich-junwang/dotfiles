# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/.bash_profile

HISTFILE=~/.zsh_history
SAVEHIST=200000
HISTSIZE=200000
setopt SHARE_HISTORY

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
# plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh


# color support
autoload -U colors && colors

## Completions
autoload -U compinit
compinit -C

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# ZPlug configuration



if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi

# Test if ~/.aliases exists and source it
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi



# export CLICOLOR=1
# export TERM=xterm-256color

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source "$ZSH/custom/plugins/zsh-git-prompt/zshrc.sh"


alias pdn='ssh -A ec2-user@ec2-3-219-35-24.compute-1.amazonaws.com'
export pdn='ec2-user@ec2-3-219-35-24.compute-1.amazonaws.com'

export PATH=~/anaconda3/bin:$PATH

xclip="xclip -selection c"
#alias pip3=/Users/juwanga/anaconda3/bin/pip3
alias pip=pip3
alias copy='xclip -selection clipboard'
alias paste='xclip -selection clipboard -o'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias python=/usr/bin/python3

# usage:
# watch_and_sync_to   my_server_name:/mnt_out/my_folder
#
function watch_and_sync_to {
        fswatch -o . | xargs -n1 -I{} rsync --exclude '*cache_exp*' -azP *(D)  $1
}

#function aws_watch_and_sync_to {
#  fswatch -o . | xargs -n1 -I{} rsync -azP --delete *(D) $1
#}

function aws_watch_and_sync_to {
  fswatch -o . | xargs -n1 -I{} rsync -azP -e "proxycommand ssh -W %h:%p 18.234.246.23" *(D) $1
}


# to use the following function, have to put krsync under PATH
# usage:
# krsync_watch_and_sync_to   my_pod_name:/mnt_out/my_folder
function krsync_watch_and_sync_to {
  fswatch -o . | xargs -n1 -I{} krsync -av --progress --stats *(D) $1
}

# adapted from https://github.com/kshenoy/dotfiles/blob/master/tmux/tmuxw.bash
# usage:
#  tmux_send_keys_all_panes 'export $(ada credentials print --account my_aws_account --role=Admin --profile codd --format env | xargs -L 1) ' Enter
#
tmux_send_keys_all_panes() {
    for _pane in $(tmux list-panes -F '#P'); do
        tmux send-keys -t ${_pane} "$@"
    done
}

