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
3. [Nerd forms](https://github.com/ryanoasis/nerd-fonts) to display icons in NerdTree (recomended font: dejavu sans mono for powerline nerd font)
4. `brew install ripgrep` for faster CTRLP
5. `brew install neovim`
6. `brew install tmux`

### for JS developement
1. `npm install -g eslint prettier eslint_d`
2. `npm install -g tern` for Javascript development


### for Dart developement
1.  [dart_language_server](https://github.com/natebosch/dart_language_server)


### to use this on a mac
1. `brew install reattach-to-user-namespace`

## Tmux
1. [plugin manager](https://github.com/tmux-plugins/tpm)

### Create symbolic links
`Create the folders (~/.config/nvim) if they don't exist`

1. `ln -s ~/development/dotfiles/init.vim ~/.config/nvim/init.vim`
2. `ln -s ~/development/dotfiles/.tmux.conf ~/.tmux.conf`
3. `ln -s ~/development/dotfiles/.zshrc ~/.zshrc`
4. `ln -s ~/development/dotfiles/after/ ~/.config/nvim/`
5. `ln -s ~/development/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json`


### Install the COC extensions
- [Snippets](https://github.com/neoclide/coc-snippets)
- [Flutter](https://github.com/iamcco/coc-flutter)
- [Git](https://github.com/neoclide/coc-git)
- HTML, JS, CSSand JSON `:CocInstall coc-tsserver coc-json coc-html coc-css`



### Finally
1. Get a OAuth github token for HomeBrew
2. `brew cask install font-firacode-nerd-font font-firacode-nerd-font-mono`
3. `brew cask install font-dejavusansmono-nerd-font font-dejavusansmono-nerd-font-mono font-dejavu-sans-mono-for-powerline`
