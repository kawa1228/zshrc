# 環境変数
export LANG=ja_JP.UTF-8

# PATHの設定
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.phpenv/bin:$PATH"

eval "$(pyenv init -)"
eval "$(nodenv init -)"
eval "$(rbenv init -)"
eval "$(phpenv init -)"

# alias
alias ls='ls -aF'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ...='cd ../..'
alias ....='cd ../../..'
alias tree='tree -NC'
alias vi='nvim'
alias cat='cat -n'
alias less='less -NM'
alias rm='rm -f'

# git alias
alias g='git'
#alias gb='git branch'
#alias gsta='git status'
#alias gadd='git add'
#alias gcom='git commit'
#alias gco='git checkout'
#alias gdif='git diff'
#alias ggrep='git grep'

# rails alias
alias be='bundle exec'
alias spec='bundle exec rspec'

# php alias

# bindkey -v

# docker alias
alias d="docker"
alias dc="docker-compose"

# kubernetes alias
alias k="kubectl"

# ディレクトリとシンボリックリンクと実行ファイルに色付けする
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

export EDITOR=vi

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ディレクトリ名のみでcdする
setopt auto_cd

# cd後にlsを実行
function chpwd() { ls }

# 移動したディレクトリを記録する
setopt auto_pushd

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct

# ビープ音を鳴らさない
setopt no_beep

# prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd() { vcs_info }
PROMPT='%m:%F{green}%~%f %n %F{yellow}$%f '
RPROMPT='${vcs_info_msg_0_}'

export CLICOLOR=1
export XDG_CONFIG_HOME=~/.config

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history
