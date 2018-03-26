# dotfiles

## Requiremients
1. python 3
  a. brew install python3
  b. Install neovim with `pip3`, python3 package manager. `pip3 install neovim`
2. [the_silver_searcher](https://github.com/ggreer/the_silver_searcher), for quick search/find
3. [Nerd forms][https://github.com/ryanoasis/nerd-fonts] to display icons in NerdTree (recomended font: dejavu sans mono for powerline nerd font)
4. `brew install ripgrep` for faster CTRLP

### for JS developement
4. `npm install -g eslint prettier eslint_d`
5. `npm install -g tern` for Javascript development


### to use this on a mac
6. `brew install reattach-to-user-namespace`

## Tmux
1. [plugin manager](https://github.com/tmux-plugins/tpm)

Symblink `ln -s ~/Development/dotfiles/init.vim ~/.config/nvim/init.vim`
Symblink `ln -s ~/Development/dotfiles/.tmux.conf ~/.tmux.conf`
