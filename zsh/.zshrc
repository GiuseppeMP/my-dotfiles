# archlinux aliases
if [[ "$OSTYPE" == "linux"* ]]; then
        alias sudo='sudo '
        alias pac='sudo pacman -S '
        alias pacu='sudo pacman -U '
        alias yays='yay -Ss --noconfirm '
        alias yayi='yay -S --noconfirm '
fi

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
    kitty-integration
    unfunction kitty-integration
fi

export HISTSIZE=10000000
export SAVEHIST=10000000

export BAT_THEME="tokyonight_night"
export NVIM_OBSIDIAN_VAULTS="~/Documents/beppe-general"

# Aliases
alias g='git'
alias gcam='git commit -a -m'
# alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias ff="fd --type f --hidden --exclude .git | fzf-tmux --bind ctrl-k:preview-page-up,ctrl-j:preview-page-down --preview='bat --color=always --style=numbers {}'  -p | xargs nvim"
alias pn=pnpm
alias notes='zi beppe-general && nvim'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Environment/bin:$PATH"
export PATH="$HOME/Environment/structurizr-cli-1.20.1:$PATH"
export PATH="$HOME/Environment/flutter/bin:$PATH"

#eval $(thefuck --alias)
export LC_CTYPE=en_US.UTF-8

export GIT_USER=giuseppemp
export OPENAI_KEY=`echo $pass | gpg --decrypt ~/.config/secrets/open_ai_key.txt.gpg 2> /dev/null`


# export SPACESHIP_PROMPT_ASYNC=true
# export SPACESHIP_VI_MODE_COLOR="white"
# ZSH_THEME="spaceship"
# source "$HOME/.config/.zsh/spaceship/spaceship.zsh"

export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-22.2.0+java17/Contents/Home
export PATH=/Library/Java/JavaVirtualMachines/graalvm-22.2.0+java17/Contents/Home/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/graalvm-22.2.0+java17/Contents/Home

export ANDROID_SDK=/Users/giuseppemp/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_SDK/cmdline-tools/latest/bin

# add asdf to zsh
. "$HOME/.asdf/asdf.sh"

# Java home asdf set
. ~/.asdf/plugins/java/set-java-home.zsh

zmodload zsh/zprof

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

## WARN change to your install folder
source ~/.oh-my-zsh/oh-my-zsh.sh

eval "$(zoxide init zsh)"

## direnv hook
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

export PATH="/usr/local/sbin:$PATH"

# export OPENAI_API_HOST="api.openai.com"

alias update-nvim-stable='asdf uninstall neovim stable && asdf install neovim stable'
alias update-nvim-nightly='asdf uninstall neovim nightly && asdf install neovim nightly'
alias update-nvim-master='asdf uninstall neovim ref:master && asdf install neovim ref:master'

# monitors

alias x_use_both_monitors='xrandr --output DisplayPort-2 --primary --mode 1920x1080 -r 144 --output HDMI-A-0 --mode 1920x1080 -r 75 --left-of DisplayPort-2'

alias x_use_only_one='xrandr --output DisplayPort-2 --primary --mode 1920x1080 -r 165 --output HDMI-A-0 --off'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Plugin history-search-multi-word loaded with investigating.
zinit load zdharma-continuum/history-search-multi-word

# Two regular plugins loaded without investigating.
zinit load zsh-users/zsh-autosuggestions

zinit load zdharma-continuum/fast-syntax-highlighting

zinit load jeffreytse/zsh-vi-mode

zinit load mrjohannchang/zsh-interactive-cd

zstyle :plugin:history-search-multi-word reset-prompt-protect 1

autoload history-search-multi-word
zle -N history-search-multi-word
zle -N history-search-multi-word-backwards history-search-multi-word
zle -N history-search-multi-word-pbackwards history-search-multi-word
zle -N history-search-multi-word-pforwards history-search-multi-word
zstyle ":history-search-multi-word" page-size "8"
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
zstyle ":plugin:history-search-multi-word" synhl "yes"
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"

plugins=(
    git # git aliases and suggestions
    magic-enter # press Enter to custom commands based on context
    spring # spring cli aliases and autocomplete
    asdf # asdf autosuggestions
    zsh-vi-mode
    # aws # awscli support
    # history-search-multi-word
    brew # brew alias bubo, bcubc, bcubo
    history-search-multi-word
    zsh-interactive-cd
)

# The plugin will auto execute this zvm_after_init function
function zvm_after_init() {
  # zvm_bindkey viins '^Z' fancy-ctrl-z
    zvm_bindkey viins "^R" history-search-multi-word
}

# Pomodoro / Focus stuff
# Requires https://github.com/caarlos0/timer to be installed
# brew install caarlos0/tap/timer

# Mac setup for pomo
alias work="timer 30m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
        
alias break="timer 5m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias yt="timer 15m && terminal-notifier -message 'Pomodoro'\
        -title 'YT video is going to far, checkout and take a break! 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"


# Created by `pipx` on 2024-01-30 23:27:43
export PATH="$PATH:/Users/giuseppemp/.local/bin"
