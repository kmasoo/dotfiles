# ==========================================================
# 0. パス（PATH）の設定
# ==========================================================
# 重複登録を防ぐ設定
typeset -U path

# 自作スクリプトのディレクトリ（例: ~/.local/bin）を追加
# 複数のディレクトリを追加する場合は path=(~/bin ~/.local/bin $path) のように記述します
path=(~/tool/yz3.1/yz3_linux $path)

# 最後にexport
export PATH

# ==========================================================
# 1. 基本・色の設定
# ==========================================================
autoload -Uz colors && colors
autoload -Uz compinit && compinit

# 補完候補の色付け
export LS_COLORS='di=01;36:ln=01;35:so=32:pi=33:ex=01;32:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# 補完挙動
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 1

# ==========================================================
# 2. プロンプトの設定
# ==========================================================
PROMPT="%F{cyan}%n%f@%F{magenta}%m%f:%F{yellow}%~%f
%F{magenta}$%f "
RPROMPT="%F{white}[%D{%H:%M:%S}]%f"

# ==========================================================
# 3. ヒストリー・ディレクトリ操作 & キーバインド
# ==========================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups
setopt auto_list
setopt auto_cd
setopt auto_pushd

# 履歴検索
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# --- キーバインド修正 ---
bindkey "^[[3~" delete-char      # Deleteキーの修正
bindkey "^[[H" beginning-of-line # Homeキー
bindkey "^[[F" end-of-line       # Endキー

# ==========================================================
# 4. エイリアス (Git短縮コマンド含む)
# ==========================================================
alias ls='ls --color=auto'
alias ll='ls -alF'
alias grep='grep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ..='cd ..'
alias ...='cd ../..'

# Git エイリアス
alias gst='git status'
alias ga='git add'
alias gaa='git add --all'
alias gcmsg='git commit -m'
alias gp='git push'
alias gl='git pull'
alias glo='git log --oneline --graph --decorate'

# 比較ツール
alias diffs='diff --color=auto -y --suppress-common-lines -W 150'
alias diffdir='diff -qr'
alias pdfv='diff-pdf --view'
alias yzf='run_yz3_sample.sh &'
# ==========================================================
# 5. 関数 (Emacs連携など)
# ==========================================================
pdfdiff() {
    diffs <(pdftotext "$1" -) <(pdftotext "$2" -)
}

ediff() {
    emacsclient -nw --eval "(ediff-files \"$1\" \"$2\")"
}

# ==========================================================
# 6. プラグイン & SSH認証
# ==========================================================
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# シンタックスハイライト色設定
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SSH Agent 自動起動
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add ~/.ssh/id_ed25519
fi
