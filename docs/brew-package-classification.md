# Brew package classification

Initial seed for Task 3. This classification is based on:
- Current package installs in `install.sh`.
- Current repo-managed config references in `stow/` and `scripts/setup-dotfiles.sh`.

Mapping to files:
- `Brewfile`: `core-personal`
- `Brewfile.optional`: `optional`
- `Brewfile.legacy`: `legacy`

Intended usage:
- Core setup: `brew bundle --file Brewfile`
- Optional extras: `brew bundle --file Brewfile.optional`
- Legacy compatibility only (transitional): `brew bundle --file Brewfile.legacy`

## core-personal

Packages that map to current dotfiles usage and day-to-day local setup.

### taps

- `FelixKratz/formulae` (for `borders`, `sketchybar`)
- `nikitabobko/tap` (for `aerospace` cask)
- `xcodesorg/made` (for `xcodes`)

### formulae

- `python3`
- `fzf`
- `coreutils`
- `wget`
- `ripgrep`
- `fd`
- `tmux`
- `neovim`
- `gnu-sed`
- `luarocks`
- `git-delta`
- `bat`
- `asdf`
- `codex`
- `cocoapods`
- `gpg`
- `gawk`
- `docker`
- `fastlane`
- `gh`
- `ios-deploy`
- `jq`
- `stylua`
- `ruff`
- `opencode`
- `borders`
- `switchaudio-osx`
- `blueutil`
- `lua`
- `nowplaying-cli`
- `sketchybar`
- `watchman`
- `xcodesorg/made/xcodes`
- `zoxide`
- `eza`

### casks

- `font-hack-nerd-font`
- `nikitabobko/tap/aerospace`

## optional

Useful tools that are not required for the core dotfiles behavior.

### taps

- `fsouza/prettierd`
- `stripe/stripe-cli`
- `supabase/tap`

### formulae

- `aria2`
- `bottom`
- `btop`
- `ffmpeg`
- `fsouza/prettierd/prettierd`
- `glow`
- `kepubify`
- `librsvg`
- `mole`
- `mysql`
- `nmap`
- `postgis`
- `postgresql@14`
- `redis`
- `stripe/stripe-cli/stripe`
- `supabase/tap/supabase`
- `worktrunk`
- `lazygit`

### casks

- `sf-symbols`

## legacy

Entries currently present in `install.sh` but likely transitional or legacy.

### taps

- `shaunsingh/SFMono-Nerd-Font-Ligaturized`

### casks

- `font-sf-mono-nerd-font-ligaturized`

### formulae

- `heroku`
- `jpeg`
- `python-setuptools`

### notes

- Keep these for now to avoid removing anything from user setup before migration is validated.
