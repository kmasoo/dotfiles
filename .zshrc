# ==========================================================
# 1. 基本・色の設定
# ==========================================================
# 色の設定を有効にする
autoload -Uz colors && colors

# 補完機能を有効にする
autoload -Uz compinit && compinit

# 補完候補に色を付ける (ディレクトリを明るいシアンに) 
export LS_COLORS='di=01;36:ln=01;35:so=32:pi=33:ex=01;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 補完時の挙動設定 
zstyle ':completion:*:default' menu select=1        # 補完候補を矢印キーで選択
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字小文字を区別しない
zstyle ':completion:*' completer _complete _match _approximate # 近似マッチ補完 
zstyle ':completion:*:approximate:*' max-errors 1

# ==========================================================
# 2. プロンプトの設定
# ==========================================================
# 左側: ユーザー(シアン)@ホスト(マゼンタ):パス(イエロー) 改行後に $(マゼンタ) 
PROMPT="%F{cyan}%n%f@%F{magenta}%m%f:%F{yellow}%~%f
%F{magenta}$%f "

# 右側: 実行時刻を表示 
RPROMPT="%F{white}[%D{%H:%M:%S}]%f"

# ==========================================================
# 3. ヒストリー・ディレクトリ操作 & キーバインド
# ==========================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups     # 重複するコマンドは記録しない 
setopt auto_list            # 補完候補を一覧表示 
setopt auto_cd              # ディレクトリ名入力だけで移動 [cite: 1, 2]
setopt auto_pushd           # 移動履歴を記録 (cd - [Tab] で選択可能) [cite: 2]

# --- キーバインド設定 ---
# 上下キーで履歴検索 [cite: 2]
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Deleteキーで~が表示される問題を修正
bindkey "^[[3~" delete-char
# Home / End キーを有効化
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# ==========================================================
# 4. エイリアス (短縮コマンド)
# ==========================================================
# 基本操作 [cite: 2]
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'

# 安全のための確認 [cite: 2]
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ディレクトリ移動の短縮 [cite: 2]
alias ..='cd ..'
alias ...='cd ../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# ファイル・ディレクトリ比較 [cite: 2]
alias diffs='diff --color=auto -y --suppress-common-lines -W 150'
alias diffdir='diff -qr'
alias pdfv='diff-pdf --view'

# --- Git 効率化エイリアス ---
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gcmsg='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --graph --decorate'

# ==========================================================
# 5. 関数 (便利機能)
# ==========================================================
# PDFのテキスト差分を比較 [cite: 3]
pdfdiff() {
    diffs <(pdftotext "$1" -) <(pdftotext "$2" -)
}

# Emacs の ediff で比較 [cite: 3]
ediff() {
    emacsclient -nw --eval "(ediff-files \"$1\" \"$2\")"
}

# ==========================================================
# 6. プラグイン・認証・環境設定
# ==========================================================
# プラグインの読み込み [cite: 3]
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# シンタックスハイライトの色設定 [cite: 3]
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

# fzf の読み込み [cite: 3]
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SSH Agent の自動起動設定 
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add ~/.ssh/id_ed25519
fi
