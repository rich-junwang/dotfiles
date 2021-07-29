# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source ~/.bash_profile
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

if [[ ! -f $HOME/.zplug/init.zsh ]] {
	echo "ZPLUG not installed!!!"
}
source ~/.zplug/init.zsh

OMZPLUGIN=("git" "python" "vi-mode")
OMZCUSPLUGIN=("zsh-syntax-highlighting" "zsh-autosuggestions" "zsh-history-substring-search" "zsh-completions")

for plug in "${OMZPLUGIN[@]}"
do
    zplug "$ZSH/plugins/$plug/$plug.plugin.zsh" , from:local
done
for plug in "${OMZCUSPLUGIN[@]}"
do
    zplug "$ZSH/custom/plugins/$plug/$plug.plugin.zsh" , from:local
done
if ! zplug check --verbose; then
    echo 'Run "zplug install" to install'
fi
# Then, source plugins and add commands to $PATH
zplug load

if [ -f ~/.zshrc_local ]; then
	source ~/.zshrc_local
fi

# Test if ~/.aliases exists and source it
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

AUTOJUMP="$ZSH/custom/plugins/autojump"
if [[ ! -d ~/.autojump ]] {
	echo "autojump not installed!!!"
}

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u
if [[ ! -d $HOME/.fzf ]] {
	echo "fzf not installed!!!"
}

# export CLICOLOR=1
# export TERM=xterm-256color

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# source "$ZSH/custom/plugins/zsh-git-prompt/zshrc.sh"


function watch_and_sync_to {
        fswatch -o . | xargs -n1 -I{} rsync -azP *(D)  $1
}

#function aws_watch_and_sync_to {
#  fswatch -o . | xargs -n1 -I{} rsync -azP --delete *(D) $1
#}

function aws_watch_and_sync_to {
  fswatch -o . | xargs -n1 -I{} rsync -azP -e "proxycommand ssh -W %h:%p 18.234.246.23" *(D) $1
}


alias pdn='ssh -A ec2-user@ec2-3-219-35-24.compute-1.amazonaws.com'
export pdn='ec2-user@ec2-3-219-35-24.compute-1.amazonaws.com'


hb_watch_and_sync_to () {
    fswatch -o $1  | xargs -n1 -I{} ~/HBDoryUtils/bin/hb.py rsync $1 $2 --rsync-args "-azP --delete"
}

export PATH=~/anaconda3/bin:$PATH

xclip="xclip -selection c"
alias pip3=/Users/juwanga/anaconda3/bin/pip3
