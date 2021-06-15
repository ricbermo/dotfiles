# dotfiles

## Requiremients
1. python 3
  - brew install python3
  - install neovim with `pip3`, python3 package manager. `pip3 install neovim`
  - neovim node package: `npm install -g neovim`
  - neovim ruby gem: `gem install neovim`
  - run `pip3 install --user --upgrade neovim` to upgrade py3 neovim.
  - install py2 neovim `pip2 install --user --upgrade neovim`
2. [the_silver_searcher](https://github.com/ggreer/the_silver_searcher), for quick search/find
3. Install [Fira Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts)
4. `brew install ripgrep` for faster CTRLP
5. `brew install neovim`
6. `brew install tmux`
7. `brew install bat`
8. Install [LS_COLORS](https://github.com/trapd00r/LS_COLORS/issues/150#issuecomment-600887571)
10. `git clone https://github.com/wfxr/forgit ~/.oh-my-zsh/custom/plugins/forgit`
11. `git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm`
12. Run `sudo xcode-select --switch /Applications/Xcode.app`

## Tmux
1. [plugin manager](https://github.com/tmux-plugins/tpm)

### Create symbolic links
`Create the folders (~/.config/nvim and ~/.config/alacritty) if they don't exist`

1. `ln -s ~/development/dotfiles/init.vim ~/.config/nvim/init.vim`
2. `ln -s ~/development/dotfiles/.tmux.conf ~/.tmux.conf`
3. `ln -s ~/development/dotfiles/.zshrc ~/.zshrc`
4. `ln -s ~/development/dotfiles/after/ ~/.config/nvim/`
5. `ln -s ~/development/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json`
6. `ln -s ~/development/dotfiles/alacritty.yml  ~/.config/alacritty/alacritty.yml`

### for JS developement
1. Install node using NVM, then set it as default using `nvm alias default <version>`
2. `:CocInstall coc-tsserver coc-json coc-html coc-css coc-snippets coc-flutter coc-git coc-yaml coc-prettier coc-eslint`


### for Dart developement
1.  [dart_language_server](https://github.com/natebosch/dart_language_server)


### Usefull guides
1. [Install Ruby](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/?utm_source=stackoverflow)
