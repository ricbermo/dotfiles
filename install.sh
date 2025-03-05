#!/bin/sh

# NOTES
# 1. give it exec permissions with chmod +x install.sh
# 2. execute this from root
# 3. install xcode first

# Accept the license
sudo xcodebuild -license
# Necessary Directories
echo "Creating directories..."
mkdir -p  ~/.config/

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
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/$USER/.zprofile
sleep 1
eval "$(/opt/homebrew/bin/brew shellenv)"
brew analytics off

# General packages
echo "Installing packages..."
brew install python3 fzf coreutils wget ripgrep fd

# Fonts
echo "Installing fonts..."
brew install --cask font-hack-nerd-font
brew install --cask sf-symbols
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Oh-My-Zsh
echo "Installing ZSH..."
wget -O https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/lscolors.sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# echo "Setting up ZSH..."
git clone https://github.com/wfxr/forgit.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
ln -sf ~/development/dotfiles/.zshrc ~/.zshrc

# Kitty
# echo "Installing Kitty..."
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# ln -s ~/development/dotfiles/kitty ~/.config/

# TMUX
brew install tmux
echo "Installing Tmux..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/development/dotfiles/.tmux.conf ~/.tmux.conf

# Neovim
echo "Installing Neovim..."
brew install neovim gnu-sed luarocks
git clone https://github.com/$USER/yanc ~/.config/nvim

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

# ASDF Version Manager, Node, Python & Ruby
echo "Installing Node, Python and tooling..."
brew install asdf gpg gawk stylua ruff
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add python
asdf install nodejs latest
asdf install python latest
asdf install ruby 3.2.2
asdf global nodejs latest
asdf global python latest
asdf global ruby 3.2.2

# SKHD
echo "Installing skhd..."
brew install koekeishiya/formulae/skhd
ln -s ~/development/dotfiles/skhd ~/.config/
skhd --start-service

# Yabai
echo "Installing Yabai..."
brew install koekeishiya/formulae/yabai
ln -s ~/development/dotfiles/yabai ~/.config/
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
chmod +x ~/.config/yabai/yabairc
yabai --start-service


# Sketchybar
echo "Installing Sketchybar..."
brew install jq switchaudio-osx blueutil
brew tap FelixKratz/formulae
brew install sketchybar
ln -s ~/development/dotfiles/sketchybar ~/.config/
chmod +x ~/.config/sketchybar/plugins/*
brew services start sketchybar

# Ramdon development goodies
echo "Installing development packages..."
brew install fsouza/prettierd/prettierd
brew install redis

# Lazygit
echo "Installing Lazygit..."
brew install lazygit


# Conda (Miniforge)
# asdf install python miniforge3-latest
# conda config --set auto_activate_base false

# Keep this at the end so the script keeps running
exec zsh
