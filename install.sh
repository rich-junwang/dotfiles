#!/bin/bash
########################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

OS="$(uname)"

if [ "$OS" = "Linux" ]; then
    # Assuming Ubuntu/Debian
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt -y install git curl
    else
        echo "apt not found. This script supports only Ubuntu/Debian-based Linux distributions."
        exit 1
    fi
elif [ "$OS" = "Darwin" ]; then
    # macOS
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew update
    brew install git curl
else
    echo "Unsupported OS: $OS"
    exit 1
fi


########## Variables

# install all the submodules

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
	echo "zsh having been installed!!!"
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "install oh-my-zsh!!!"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
    if [ ! "$SHELL" == "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
	echo "installing zsh!!!"
    if [[ $platform == 'Linux' ]]; then
        if [[ -f /etc/redhat-release ]]; then
            sudo yum install zsh
            install_zsh
        fi
        if [[ -f /etc/debian_version ]]; then
            sudo apt-get install zsh
            install_zsh
        fi
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}
install_zsh

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"           # dotfiles directory
olddir=~/dotfiles_old      # old dotfiles backup directory

for file in $submodules; do
	echo $file
	git submodule update --init $file
done


files="bashrc bash_profile vimrc vim zshrc gitconfig gitignore_global tmux.conf aliases zplug fzf "

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd "$dir" || exit
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/."$file" ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -fns "$dir"/"$file" ~/."$file"
done


#cd "$ZSH_CUSTOM_PLUG/autojump" || exit 
#./install.py

# ~/.fzf/install

rm -rf ~/.zcompdump*
rm -rf ~/.zplug/zcompdump*

git clone git://github.com/rich-junwang/.vim.git ~/.vim && sh ~/.vim/setup.sh
