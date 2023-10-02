zmodload zsh/zprof
# LS_COLORS support https://github.com/trapd00r/LS_COLORS
source $HOME/lscolors.sh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Forgit copy command
FORGIT_COPY_CMD='xclip -selection clipboard'

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

source ~/.oh-my-zsh/custom/plugins/forgit

plugins=(
  asdf 
  git
  forgit
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nv="nvim"
alias cl="clear"
alias rra="npx react-native run-android"
alias rri="npx react-native run-ios"
alias rrs="npx react-native start"
alias rrsr="rrs --reset-cache"
alias tt="npm test"
alias e2e="npm run test:e2e"
alias getip="ipconfig getifaddr en0"
alias tmn="tmux new -s"
alias tat="tmux attach -t"
alias cdev="cd ~/development && tmux new -s dev"
alias cnm="rm -rf node_modules && npm i"
alias apk="cd android && ./gradlew clean && ./gradlew assembleRelease; cd ..; open android/app/build/outputs/apk/release"
alias bla="cd android && ./gradlew clean && ./gradlew bundleRelease; cd ..; open android/app/build/outputs/bundle/release"
alias fr="flutter run"
alias fp="flutter pub get"
alias fe="flutter emulators"
alias fei="flutter emulators --launch apple_ios_simulator"
alias fea="flutter emulators --launch Pixel_4_XL_API_26"
alias fw="flutter packages pub run build_runner watch --delete-conflicting-outputs"
alias ft="flutter test"
alias redis="/usr/local/opt/redis/bin/redis-server /usr/local/etc/redis.conf"
alias mr="npm run migration:run"
alias mrr="npm run migration:revert"
alias mg="npm run migration:generate"
alias amend="git commit --amend --no-edit"
alias lg="lazygit"

export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/tools
# PATH="$PATH:$ANDROID_PLATFORM_TOOLS"
PATH="$PATH:$HOME/.fastlane/bin"
PATH="$PATH:$HOME/fvm/default/bin"
PATH="$PATH:$HOME/fvm/default/.pub-cache/bin"
PATH="$PATH:$HOME/fvm/default/bin/cache/dart-sdk/bin"
PATH="$PATH:$HOME/.pub-cache/bin"
PATH="$PATH:$HOME/.rvm/bin"
export PATH

export REACT_EDITOR=nvim

#openssl
export PATH="/usr/local/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ricardo/.asdf/installs/python/miniforge3-latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ricardo/.asdf/installs/python/miniforge3-latest/etc/profile.d/conda.sh" ]; then
        . "/Users/ricardo/.asdf/installs/python/miniforge3-latest/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ricardo/.asdf/installs/python/miniforge3-latest/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

