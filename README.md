# dotfiles

## Requiremients
- python 3
  - brew install python3
  - install neovim with `pip3`, python3 package manager. `pip3 install neovim`
  - run `pip3 install --user --upgrade neovim` to upgrade py3 neovim.
  - install py2 neovim `pip2 install --user --upgrade neovim`
- Install a [Nerd Font](https://github.com/ryanoasis/nerd-fonts) (Liga SFMono Nerd Font preferred)
- `brew install tmux`
- `brew install fzf`
- Install [LS_COLORS](https://github.com/trapd00r/LS_COLORS/issues/150#issuecomment-600887571)
- [Forgit](https://github.com/wfxr/forgit)
 - `git clone https://github.com/wfxr/forgit ~/.oh-my-zsh/custom/plugins/forgit`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

## Tmux
- [Plugin manager](https://github.com/tmux-plugins/tpm)

### Create symbolic links
- `ln -s ~/development/dotfiles/.tmux.conf ~/.tmux.conf`
- `ln -s ~/development/dotfiles/.zshrc ~/.zshrc`
- `ln -s ~/development/dotfiles/kitty ~/.config/`

### Setup Yanc
- https://github.com/ricbermo/yanc


### Goddies
- [Delta](https://github.com/dandavison/delta#installation)
- [Bat](https://github.com/sharkdp/bat)
 - [Catppuccin theme](https://github.com/catppuccin/bat)