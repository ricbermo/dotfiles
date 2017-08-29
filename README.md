# dotfiles

## Requiremients
1. Neovim with python3 support, so [depoplete](https://github.com/Shougo/deoplete.nvim) and others can work properly
  a. Install neovim with `pip3`, python3 package manager.
2. [the_silver_searcher](https://github.com/ggreer/the_silver_searcher), for quick search/find
3. [Nerd forms][https://github.com/ryanoasis/nerd-fonts] to display icons in NerdTree (recomended font: dejavu sans mono for powerline nerd font)

### for JS developement
4. `npm install -g eslint prettier eslint_d`
5. `npm install -g tern` for Javascript development


### to use this on a mac
6. `brew install reattach-to-user-namespace`

## Tmux
1. [plugin manager](https://github.com/tmux-plugins/tpm)

Symblink `ln -s ~/Development/dotfiles/init.vim ~/.config/nvim/init.vim`
Symblink `ln -s ~/Development/dotfiles/.tmux.conf ~/.tmux.conf`
