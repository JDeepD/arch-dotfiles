#!/bin/bash

echo "Please install the following packages manually using your package manager:"
echo
echo " 1. cURL"
echo " 2. git"
echo " 3. neovim(0.5+ is preffered)"
echo " 4. zsh"
echo " 5. xclip"
echo " 6. starship"
echo " 7. openssh"
echo
printf "DID YOU INSTALL THE ABOVE PACKAGES [Y/N] "; read bool


if [ $bool == "Y" ] || [ $bool == "y" ]; then
	echo
	echo "Beginning setup..."
	echo
	if [ ! -d "arch-dotfiles" ]; then
		git clone --branch install --single-branch https://github.com/JDeepD/arch-dotfiles.git || git clone --branch install --single-branch git@github.com:JDeepD/arch-dotfiles.git 
	else
		echo "Arch-dotfiles already exists. Copying files..."
	fi
	echo
	echo "Creating directories and copying files..."
	echo
	mkdir -p config/{nvim/plugged,starship}
	cp -v arch-dotfiles/.config/nvim/init.vim config/nvim/init.vim
	cp -v arch-dotfiles/.config/nvim/plugged/plugins.vim config/nvim/plugged/plugins.vim
	cp -v arch-dotfiles/.config/starship/config.toml config/starship/config.toml
	cp -v arch-dotfiles/.zshrc .zshrc
	cp -v arch-dotfiles/.vimrc .vimrc
	cp -r arch-dotfiles/.fonts . 
	cp -R arch-dotfiles/.vim .
	cp -R arch-dotfiles/antigen .
	cp -R arch-dotfiles/.wallpaper .

	echo "==============================================================================================="
	echo
	printf "Do you have your github ssh keys in .ssh? [Y/N] "; read answer
	if [ $answer == "Y" ] || [ $answer == "y" ]; then
		printf "Enter a branch name for upstream: "; read branch
		printf "Enter the private ssh key[file name] authenticated with github : " ; read key
		if [ -z $key ] || [ -e "~/.ssh/$key" ]; then
			echo "Invalid key/Key does not exist in ~/.ssh"
			exit 1
		fi
		echo "Running ssh agent..."
		eval "$(ssh-agent -s)"
		ssh-add ~/.ssh/$key
		git init
		git add .
		git commit -m "First commit"

		git remote add origin git@github.com:JDeepD/dotfiles.git
		git remote add upstream git@github.com:JDeepD/arch-dotfiles.git
		git branch $branch
		git push -u origin $branch:$branch
		rm -rf arch-dotfiles

		echo "This system config was uploaded to JDeepD/dotfiles branch: $branch"
		echo "https://github.com/JDeepD/dotfiles/tree/$branch"

	else
		echo "Add your ssh keys to automatically track changes to current config in a remote repository"
		exit 1
	fi

else
	echo "Please install the above packages"
	echo "Exiting..."
	exit 1
fi


