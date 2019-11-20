# zshrc
# ©︎ 2019 ObuchiYuki

########################################
# 環境変数
export LANG=ja_JP.UTF-8

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

# vcs_infoを設定
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "! %F{green}"
zstyle ':vcs_info:git:*' unstagedstr "+ %F{magenta}"
zstyle ':vcs_info:*' formats " %F{cyan}%b"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプト設定
setopt prompt_subst
PROMPT='
%F{228}%1d%F{c}${vcs_info_msg_0_}
%(?.%F{161}.%F{124})❯ %f'

########################################
# 自己環境変数
export PATH="$HOME/.local/bin":$PATH
export PATH="/usr/local/bin":$PATH
export PATH="/usr/local/sbin":$PATH
export PATH="/usr/local/opt/openssl/bin":$PATH  
export PATH="$HOME/Library/Python/3.7/bin":$PATH


########################################
# 初期化
# Pyenv初期化
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin":$PATH
eval "$(pyenv init -)"

# Go初期化
export GOPATH=$DEVELOPER/go

# Zsh Syntax Highlighting初期化
source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Rust初期化
export PATH="$HOME/.cargo/bin":$PATH

########################################
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

########################################
# エイリアス
# オプションをデフォルトにする
alias ls='ls -G'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias cp='cp -v'
source() {
  case $1 in *_history) echo "[source] It's so dangerous to load history file with source command." >&2; return 1; esac
  builtin source "$@"
}

# 省略コマンド
alias sound-dl='youtube-dl -w -f 140 --embed-thumbnail -i -o "~/Downloads/%(title)s.%(ext)s"'
alias vim='/usr/local/bin/vim'
alias scntool='/Applications/Xcode.app/Contents/Developer/usr/bin/scntool'
alias game='sudo /System/Volumes/Data/Applications/OpenEmu.app/Contents/MacOS/OpenEmu'
alias less='/usr/share/vim/vim80/macros/less.sh'
alias python2='/usr/bin/python'
alias magica-commit='/Applications/MagicaVoxel/commit'
########################################
# 初期化コマンド
clear

