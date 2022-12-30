#!/bin/sh

# Necessary Directories
echo "Creating directories..."
mkdir ~/.config/

# macOS Settings
echo "Changing OS defaults..."
defaults write com.apple.dock autohide -bool true
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES


# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Homebrew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

# General packages
echo "Installing packages..."
brew install python3 fzf coreutils wget ripgrep

# Fonts
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized
brew install --cask  font-fira-mono-nerd-font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Oh-My-Zsh
echo "Installing ZSH..."
wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/LS_COLORS
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Setting up ZSH..."
git clone https://github.com/wfxr/forgit ~/.oh-my-zsh/custom/plugins/forgit
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
ln -s ~/development/dotfiles/.zshrc ~/.zshrc
exec zsh

# Kitty
echo "Installing Kitty..."
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/development/dotfiles/kitty ~/.config/

# TMUX
brew install tmux
echo "Installing Tmux..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s ~/development/dotfiles/.tmux.conf ~/.tmux.conf

# Neovim
echo "Installing Neovim..."
brew install neovim
git clone https://github.com/ricbermo/yanc ~/.config/nvim

# Git Delta
echo "Installing Git Delta..."
brew install git-delta
ln -s ~/development/dotfiles/.gitconfig ~/.gitconfig

# Bat (Cat with superpowers)
brew install bat
echo "Installing BAT..."
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
git clone https://github.com/catppuccin/bat.git
bat cache --build
ln -s ~/development/dotfiles/bat.config ~/.config/bat/config

# ASDF Version Manager, Node and Python
echo "Installing Node and Python..."
brew install asdf gpg gawk
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python
asdf install nodejs latest
asdf install python latest

# SKHD
echo "Installing skhd..."
brew install koekeishiya/formulae/skhd
ln -s ~/development/dotfiles/skhd ~/.config/
brew services start skhd

# Yabai
echo "Installing Yabai..."
brew install koekeishiya/formulae/yabai
ln -s ~/development/dotfiles/yabai ~/.config/
brew services start yabai


# Sketchybar
echo "Installing Sketchybar..."
brew install --cask sf-symbols
brew install jq
brew install switchaudio-osx
brew install gh
brew install sketchybar
ln -s ~/development/dotfiles/sketchybar ~/.config/
chmod +x ~/.config/sketchybar/plugins/*
brew services start sketchybar
