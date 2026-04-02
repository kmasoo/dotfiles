# ==========================================================
# 1. 基本・色の設定
# ==========================================================
# 色の設定を有効にする
autoload -Uz colors && colors

# 補完機能を有効にする
autoload -Uz compinit && compinit

# 補完候補に色を付ける (ディレクトリを明るいシアンに) [cite: 1]
export LS_COLORS='di=01;36:ln=01;35:so=32:pi=33:ex=01;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 補完時の挙動設定 [cite: 1]
zstyle ':completion:*:default' menu select=1        # 補完候補を矢印キーで選択
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない
zstyle ':completion:*' completer _complete _match _approximate # 近似マッチ補完 
zstyle ':completion:*:approximate:*' max-errors 1

# ==========================================================
# 2. プロンプトの設定
# ==========================================================
# 左側: ユーザー(シアン)@ホスト(マゼンタ):パス(イエロー) 改行後に $(マゼンタ) [cite: 1]
PROMPT="%F{cyan}%n%f@%F{magenta}%m%f:%F{yellow}%~%f
%F{magenta}$%f "

# 右側: 実行時刻を表示 [cite: 1]
RPROMPT="%F{white}[%D{%H:%M:%S}]%f"

# ==========================================================
# 3. ヒストリー・ディレクトリ操作
# ==========================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups     # 重複するコマンドは記録しない [cite: 1]
setopt auto_list            # 補完候補を一覧表示 [cite: 1]
setopt auto_cd              # ディレクトリ名入力だけで移動 [cite: 1, 2]
setopt auto_pushd           # 移動履歴を記録 (cd - [Tab] で選択可能) 

# 上下キーで履歴検索 
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# ==========================================================
# 4. エイリアス (短縮コマンド)
# ==========================================================
# 基本操作 
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'

# 安全のための確認 
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ディレクトリ移動の短縮 
alias ..='cd ..'
alias ...='cd ../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# ファイル・ディレクトリ比較 
alias diffs='diff --color=auto -y --suppress-common-lines -W 150'
alias diffdir='diff -qr'
alias pdfv='diff-pdf --view' # PDFの見た目を比較

# ==========================================================
# 5. 関数 (便利機能)
# ==========================================================
# PDFのテキスト差分を比較
pdfdiff() {
    diffs <(pdftotext "$1" -) <(pdftotext "$2" -)
}

# Emacs の ediff で比較
ediff() {
    emacsclient -nw --eval "(ediff-files \"$1\" \"$2\")"
}

# ==========================================================
# 6. プラグインの読み込みと色のカスタマイズ
# ==========================================================
# プラグインの読み込み [cite: 3]
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# シンタックスハイライトの色設定 (明るめの色に上書き) [cite: 3]
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
