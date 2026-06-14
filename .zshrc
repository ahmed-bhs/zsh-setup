# ============================================================
#  PATH exports (set BEFORE any early `return` for non-interactive shells)
# ============================================================
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Flutter
export PATH="$HOME/flutter/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Platform.sh CLI
export PATH="$HOME/.platformsh/bin:$PATH"
[ -f "$HOME/.platformsh/shell-config.rc" ] && . "$HOME/.platformsh/shell-config.rc"

# NVM (lazy-loaded below; export dir early so subshells/scripts can find it)
export NVM_DIR="$HOME/.nvm"

# Misc env
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# ============================================================
#  Non-interactive shells stop here
# ============================================================
[[ -o interactive ]] || return

# ============================================================
#  oh-my-zsh
# ============================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="spaceship"

plugins=(
  git
  docker
  docker-compose
  kubectl
  composer
  symfony
  heroku
  pip
  lein
  command-not-found
  colored-man-pages
  extract
  sudo
  fzf
  zsh-completions
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-history-substring-search
)

source "$ZSH/oh-my-zsh.sh"

# history-substring-search: bind up/down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ============================================================
#  Lazy-load NVM (fast startup; loads on first node/npm/nvm call)
# ============================================================
_load_nvm() {
  unset -f nvm node npm npx 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _load_nvm; nvm "$@"; }
node() { _load_nvm; node "$@"; }
npm() { _load_nvm; npm "$@"; }
npx() { _load_nvm; npx "$@"; }

# Make current node version available on PATH without loading nvm
if [ -s "$NVM_DIR/alias/default" ]; then
  _nvm_default="$(cat "$NVM_DIR/alias/default" 2>/dev/null)"
  _nvm_default="${_nvm_default#v}"
  [ -d "$NVM_DIR/versions/node/v$_nvm_default/bin" ] && \
    export PATH="$NVM_DIR/versions/node/v$_nvm_default/bin:$PATH"
  unset _nvm_default
fi

# ============================================================
#  History
# ============================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY \
       INC_APPEND_HISTORY HIST_IGNORE_SPACE EXTENDED_HISTORY

# ============================================================
#  zoxide (smart cd) -- use `z <dir>` and `zi` for interactive
# ============================================================
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# ============================================================
#  Aliases
# ============================================================
alias ez='~/ez'

# Modern CLI replacements (Debian binary names: batcat / fdfind)
command -v batcat >/dev/null 2>&1 && alias cat='batcat --paging=never' && alias bat='batcat'
command -v fdfind >/dev/null 2>&1 && alias fd='fdfind'
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lh --group-directories-first --git'
  alias la='eza -lah --group-directories-first --git'
  alias lt='eza --tree --level=2'
fi
command -v duf  >/dev/null 2>&1 && alias df='duf'
command -v btop >/dev/null 2>&1 && alias top='btop'

# ============================================================
#  jina autocomplete
# ============================================================
if command -v jina >/dev/null 2>&1; then
  compctl -K _jina jina
  _jina() {
    local words completions
    read -cA words
    if [ "${#words}" -eq 2 ]; then
      completions="$(jina commands)"
    else
      completions="$(jina completions ${words[2,-2]})"
    fi
    reply=(${(ps:\n:)completions})
  }
fi

# ============================================================
#  Cheatsheet (run `cheat` or `?` to show again)
# ============================================================
cheat() {
  local b=$'\e[1m' c=$'\e[36m' g=$'\e[32m' d=$'\e[2m' r=$'\e[0m'
  print -r -- "${b}${c}  SHORTCUTS${r}  ${d}(cheat to show again)${r}"
  print -r -- "${d}  ─────────────────────────────────────────────${r}"
  print -r -- "  ${g}Ctrl+R${r}      fuzzy history search        ${d}(fzf)${r}"
  print -r -- "  ${g}Ctrl+T${r}      fuzzy file picker           ${d}(fzf)${r}"
  print -r -- "  ${g}Alt+C${r}       fuzzy cd into subdir        ${d}(fzf)${r}"
  print -r -- "  ${g}prefix + UP${r} history match by prefix"
  print -r -- "  ${g}Esc Esc${r}     prepend sudo to last cmd"
  print -r -- "  ${g}Alt+arrows${r}  navigate dir history"
  print -r -- ""
  print -r -- "  ${g}z <dir>${r}     jump to frequent dir        ${d}(zoxide)${r}"
  print -r -- "  ${g}zi${r}          interactive dir jump"
  print -r -- "  ${g}ll / la${r}     list long / +hidden         ${d}(eza, git)${r}"
  print -r -- "  ${g}lt${r}          tree view (2 levels)"
  print -r -- "  ${g}cat${r}         syntax-colored cat          ${d}(bat)${r}"
  print -r -- "  ${g}fd <pat>${r}    fast file find"
  print -r -- "  ${g}rg <pat>${r}    fast grep"
  print -r -- "  ${g}extract f${r}   unpack any archive"
  print -r -- "  ${g}cheat${r} / ${g}?${r}     show this list"
  print -r -- "${d}  ─────────────────────────────────────────────${r}"
}
alias '?'='cheat'

# Auto-show on new interactive shell (skip in subshells / over SSH scripts)
if [[ -o interactive && -z "$CLAUDECODE" ]]; then
  command -v fastfetch >/dev/null 2>&1 && fastfetch
  cheat
fi

# ============================================================
#  Limits
# ============================================================
ulimit -n 4096
