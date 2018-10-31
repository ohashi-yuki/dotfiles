#####################################
# char set
#####################################
export LANG=ja_JP.UTF-8

######################################
# color
######################################
autoload -Uz colors; colors
export CLICOLOR=true
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

######################################
# setting
######################################
export SVN_EDITOR=vim
export GREP_OPTIONS='--color=auto'

######################################
# prompt
#######################################

autoload -Uz vcs_info
setopt prompt_subst
# コマンド実行ごとにvcsに問い合わせる
precmd() { vcs_info }
# http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
# 変更状態を問い合わせる リポジトリがでかいと重たいのでfalseにしたほうが良い
zstyle ':vcs_info:git:*' check-for-changes true
# git statusでクリーンな状態
# %c => ステージ済みでコミットされていないファイルがあれば stagedstrを呼ぶ
# %u => ステージされていないファイルがあれば               unstagedstrを呼ぶ
# %b => カレントブランチ名
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# rebase 途中だったり merge でコンフリクトが発生したり、何か特別な状況
zstyle ':vcs_info:*' actionformats '[%b|%a]'
# git stash
function git_stash {
    local stashCount=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    [[ $git_stash_count -eq 0 ]] && return
    echo "stash($stashCount)"
}

# 右端のプロンプト
RPROMPT='${vcs_info_msg_0_}%{${fg[magenta]}%}`git_stash`%{${reset_color}%}'

# colorの設定後にpromptの設定をすること！
# screen時にうまく引き継げない
#
# %~ => ~current directory
# %n => usernaem %m => hostname %# => usertype(#=root, %=normal)
SUCCESS='^_^'
FAIL='ToT'
ABS_PATH='%/'

PROMPT=""
PROMPT+="%(?.${fg[cyan]}$SUCCESS.${fg[red]}$FAIL) "
PROMPT+="%{${fg[green]}%}$ABS_PATH%{${reset_color}%}
[%n@%m] %# "

PROMPT2="[%n]> "

# REPORTTIME=n
# n秒以上、実行に時間がかかった場合レポーティングする
REPORTTIME=3

######################################
# complete
######################################
fpath=($HOME/.zsh/zsh-completions/src(N-/) $fpath)
autoload -Uz compinit; compinit -u
# complete after = --prefix=/usr => --prefix=<Tab>
setopt magic_equal_subst
# candidate pack
setopt list_packed
zstyle ':completion:*:default' menu select=2
# 補完時に大文字小文字区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

######################################
# history
######################################
HISTFILE="$HOME/.zsh_history"
# memory save num
HISTSIZE=10000
# HISTFILE save num
SAVEHIST=10000
# command of history duplication ignore
setopt hist_ignore_all_dups
# command of <Space>command ignore
setopt hist_ignore_space
# start to end timestanp
setopt extended_history
# other shell history share
setopt share_history
# reduce blanks  ls   -l => ls -l
setopt hist_reduce_blanks
# historyから、使用したコマンドを検索してくれる
# bck-i-search: の状態で、再度 ^bとすることで、コマンドを遡れる。
bindkey '^b' history-incremental-pattern-search-backward

######################################
# directory
######################################
# cd /home => /home cd ../ => ..
setopt auto_cd
# dirctory of stack push cd -<Tab>
setopt auto_pushd
# directory of stack duplication ignore
setopt pushd_ignore_dups

######################################
# other
######################################
# vim like
bindkey -v
bindkey 'jj' vi-cmd-mode
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char
# back ground job state notice
setopt notify
setopt no_beep
# command spell correct
setopt correct
# ^Dでzshを終了しない
setopt ignore_eof
# ^Q/^Sのフローコントロールを無効
setopt no_flow_control
# vimで<C-q>や<C-s>を使えるようにする
stty -ixon -ixoff
# 日本語ファイル名が表示可能
setopt print_eight_bit

######################################
# fancy-ctrl-z
# fgを<C-z>におきかえたもの
######################################
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

######################################
# peco history参照
######################################
# control + r
# .zsh_historyからコマンド履歴をインタラクティブに検索する
bindkey '^r' peco-select-history
zle -N peco-select-history
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

######################################
# cdr 移動したディレクトリの履歴
# cdr -l
######################################
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# 履歴保存用のディレクトリ作成
mkdir -p $HOME/.cache/shell/

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

######################################
# cdd
######################################

if [[ -f $HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-m4i-SLASH-cdd.git/cdd ]]; then
    source $HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-m4i-SLASH-cdd.git/cdd
    touch $CDD_FILE
    autoload -Uz add-zsh-hook
    add-zsh-hook chpwd _cdd_chpwd
fi

chpwd() {
    ls
}

######################################
# hash
# ディレクトリのエイリアスを登録できる
######################################
# CDABLE_VARSを指定することで、~を省略できる
# cd ~log => cd log
setopt CDABLE_VARS
hash -d log=/var/log
hash -d dot=$HOME/dotfiles

######################################
# ghq
######################################
function peco-ghq-list () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi

    zle clear-screen
}

zle -N peco-ghq-list
bindkey '^]' peco-ghq-list

######################################
# web_search
######################################
# url: $1, delimiter: $2, prefix: $3, words: $4..
function web_search {
  local url=$1       && shift
  local delimiter=$1 && shift
  local prefix=$1    && shift
  local query

  while [ -n "$1" ]; do
    if [ -n "$query" ]; then
      query="${query}${delimiter}${prefix}$1"
    else
      query="${prefix}$1"
    fi
    shift
  done

  open "${url}${query}"
}

function web() {
  web_search "https://www.google.co.jp/search?&q=" "+" "" "$@"
}

function phpdoc() {
  web_search "https://php.net/" "+" "" "$@"
}

######################################
# zman
######################################
# % zman SEARCH_HISTORY
function zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

######################################
# ailias
######################################
alias g='git'
alias ll='ls -lah'
alias vi='vim'
alias cl='clear'
alias sc='screen'
alias tm='tmux'
alias ag='ag --hidden'
alias reload="source $HOME/.zprofile"
alias ps-kill='kill -9'
alias showZenv="cat $HOME/.zshenv"
alias show-listen-port='lsof -i -P | grep LISTEN'
# vim finderの略
alias vf="ag -l | peco | xargs -o vim"

alias -g A='| ag --hidden'
alias -g G='| grep'
alias -g X='| xargs'
alias -g C='| cat'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g W='| wc'
alias -g P='| peco'
alias -g Px='| peco | xargs '

# Docker
alias d='docker'
alias dls='docker images' # docker ls的な意味
alias dps='docker ps -a'
alias de='docker exec -it'
alias drm='docker ps -qa | xargs docker rm'
alias drm_all='docker rmi $(sudo docker images -q)'
alias dm='docker-machine'
alias dme='eval $(docker-machine env default)'
