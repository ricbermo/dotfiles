# ------------------------------------------------------------
# OpenSpec completions (managed block)
# ------------------------------------------------------------
# Add custom completions directory so zsh can find OpenSpec completions.
# Oh My Zsh handles completion initialization, so no manual compinit here.
# OPENSPEC:START
fpath=("$HOME/.oh-my-zsh/custom/completions" $fpath)
# OPENSPEC:END

# ------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="quantum"

# Make completions case-sensitive.
CASE_SENSITIVE=true

# ------------------------------------------------------------
# Locale
# ------------------------------------------------------------
export LANG="en_US.UTF-8"

# ------------------------------------------------------------
# Default tools
# ------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export REACT_EDITOR="nvim"

# ------------------------------------------------------------
# FZF defaults
# ------------------------------------------------------------
# Use ripgrep so FZF can list files efficiently, including hidden ones,
# while ignoring the .git directory.
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# ------------------------------------------------------------
# Plugins
# Keep zsh-syntax-highlighting last.
# ------------------------------------------------------------
plugins=(
  asdf
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------
# Optional shell extras
# ------------------------------------------------------------
# Load custom LS_COLORS if present.
[[ -f "$HOME/lscolors.sh" ]] && source "$HOME/lscolors.sh"

# Load FZF key bindings and completion support if installed.
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Zoxide provides smarter directory jumping.
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Load wt shell helpers if available.
if command -v wt >/dev/null 2>&1; then
  eval "$(command wt config shell init zsh)"
fi

# Bun shell completions.
[[ -f "$HOME/.oh-my-zsh/completions/_bun" ]] && source "$HOME/.oh-my-zsh/completions/_bun"

# ------------------------------------------------------------
# History
# ------------------------------------------------------------
# Store a larger command history and keep it shared across sessions.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

setopt share_history
setopt inc_append_history
setopt extended_history

# Avoid duplicate or noisy entries.
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks

# Show expanded history command before executing it.
setopt hist_verify

# Search history using the current command prefix with arrow keys.
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ------------------------------------------------------------
# Tooling paths
# ------------------------------------------------------------
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ASDF_DATA_DIR="$HOME/.asdf"
export BUN_INSTALL="$HOME/.bun"

# Deduplicate PATH entries automatically.
typeset -U path PATH

path=(
  "$HOME/.opencode/bin"
  "$BUN_INSTALL/bin"
  "$ASDF_DATA_DIR/shims"
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/tools"
  "$ANDROID_HOME/tools/bin"
  "$ANDROID_HOME/platform-tools"
  "$HOME/.fastlane/bin"
  "$HOME/.pub-cache/bin"
  "$HOME/.local/bin"
  $path
)

# ------------------------------------------------------------
# OpenSSL
# ------------------------------------------------------------
# Fixed Homebrew OpenSSL path to avoid calling brew on every shell startup.
export OPENSSL_PATH="/opt/homebrew/opt/openssl@3"
path=("$OPENSSL_PATH/bin" $path)
export LDFLAGS="-L$OPENSSL_PATH/lib"
export CPPFLAGS="-I$OPENSSL_PATH/include"
export PKG_CONFIG_PATH="$OPENSSL_PATH/lib/pkgconfig"

export PATH

# ------------------------------------------------------------
# Aliases
# ------------------------------------------------------------
# Config shortcuts
alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'

# General shortcuts
alias nv='nvim'
alias cl='clear'
alias getip='ipconfig getifaddr en0'

# React Native / Expo
alias rra='npx react-native run-android'
alias rri='npx react-native run-ios'
alias rre='npx expo run:ios'
alias rrea='npx expo run:android'
alias rrs='npx react-native start'
alias rrsr='rrs --reset-cache'

# Tests and migrations
alias tt='npm test'
alias e2e='npm run test:e2e'
alias mr='npm run migration:run'
alias mrr='npm run migration:revert'
alias mg='npm run migration:generate'

# Tmux helpers
alias tat='tmux attach -t'
alias tnew='tmux new -d -s'

# Project utilities
alias cnm='rm -rf node_modules && npm i'
alias redis='/opt/homebrew/opt/redis/bin/redis-server /opt/homebrew/etc/redis.conf'

# Git / worktree helpers
alias lg='lazygit'
alias wsc='wt switch --create'
alias wsm='wt switch main'

# Better ls via eza
alias ls='eza --icons=always'
alias ll='eza -lah --icons=always'
alias la='eza -la --icons=always'
alias tree='eza --tree --icons=always'

# ------------------------------------------------------------
# Functions
# Functions are safer than aliases for multi-step commands.
# ------------------------------------------------------------

# Jump to your main development directory and attach/create tmux session.
cdev() {
  cd "$HOME/development" && tmux new -As projects
}

# Build Android APK and open the output folder if build succeeds.
apk() {
  (cd android && ./gradlew clean && ./gradlew assembleRelease) &&
    open android/app/build/outputs/apk/release
}

# Build Android AAB bundle and open the output folder if build succeeds.
bla() {
  (cd android && ./gradlew clean && ./gradlew bundleRelease) &&
    open android/app/build/outputs/bundle/release
}
