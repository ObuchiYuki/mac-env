# zshrc
# ©︎ 2019 ObuchiYuki


export LANG=ja_JP.UTF-8

# ============================================================================= #
# -- 初期化 -- 
if [ ! -e ~/.zsh_initirized ]; then
    cd ~/

    # install brew 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # install packages
    brew install cmake ffmpeg git lame pyenv source-highlight go atomicparsley youtube-dl
    brew install coreutils diffutils ed findutils gawk gnu-sed gnu-tar grep gzip binutils

    # syntax-highlighting
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting" ".zsh-syntax-highlighting"

    # pyenv
    yes | /usr/local/bin/pyenv install 3.7.3
    /usr/local/bin/pyenv global 3.7.3

    # initirized
    touch ~/.zsh_initirized

    echo -e "\n\e[36mInitirizing completed! Restart terminal."
    exit
else


# ============================================================================= #
# パスを通す

# PATH
export PATH="/bin":$PATH
export PATH="/sbin":$PATH
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/bin":$PATH
export PATH="/usr/local/sbin":$PATH
export PATH="/usr/local/opt/openssl/bin":$PATH  
export PATH="$HOME/Library/Python/3.7/bin":$PATH

# GNU PATH
export PATH="/usr/local/opt/grep/libexec/gnubin":$PATH
export PATH="/usr/local/opt/coreutils/libexec/gnubin":$PATH
export PATH="/usr/local/opt/findutils/libexec/gnubin":$PATH
export PATH="/usr/local/opt/binutils/bin":$PATH
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin":$PATH


export LDFLAGS="-L/usr/local/opt/binutils/lib"
export CPPFLAGS="-I/usr/local/opt/binutils/include"


# ============================================================================= #
# Zshの設定
# ============================================================================= 

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# Zsh Syntax Highlighting初期化
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# git infoを設定
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "! %F{green}"
zstyle ':vcs_info:git:*' unstagedstr "+ %F{magenta}"
zstyle ':vcs_info:*' formats " %F{cyan}%b"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# ========================= #
# プロンプト設定
setopt prompt_subst
PROMPT='
%F{228}%1d%F{c}${vcs_info_msg_0_}
%(?.%F{161}.%F{124})❯ %f'

#PROMPT='
#$fg[yellow]%1d$fg[cyan]${vcs_info_msg_0_}
#%(?.$fg[magenta].$fg[red])❯ %f'

# =================================================== #
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完候補を一覧表示にする
setopt auto_list

# TAB で順に補完候補を切り替える
setopt auto_menu

# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# ============================================================================= #
# ここまでZshの設定
# ============================================================================= #



# ============================================================================= #
# Command変更
# =================================================== #
# コマンド初期化

# Pyenv初期化
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin":$PATH
eval "$(pyenv init -)"

# Go初期化
export GOPATH=$DEVELOPER/go

# =================================================== #
# aliases

# default
alias ls='ls --color'
alias grep='grep --color'
alias cp='cp -v'
alias mv='mv -v'
alias which='type -a'

# append
alias sound-dl='youtube-dl -w -f 140 --embed-thumbnail -i -o "~/Downloads/%(title)s.%(ext)s"'

# lessで色が見えるように
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

# sourceでhisotory読み込まないように
source() {
  case $1 in *_history) echo "[source] It's so dangerous to load history file with source command." >&2; return 1; esac
  builtin source "$@"
}


# rmはrm_realに
alias rm_real='rm'

# rmはゴミ箱にmvにする
if [ -d ${HOME}/.Trash ]
then
    alias rm='mv --backup=numbered --target-directory=${HOME}/.Trash'
fi


# ============================================================================= #
# Command変更


# =================================================== #
# 初期化
clear



fi
