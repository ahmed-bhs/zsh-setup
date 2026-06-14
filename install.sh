#!/usr/bin/env bash
set -e

echo "==> Installing apt packages"
sudo apt-get update -qq
for pkg in fzf zoxide bat eza fd-find btop duf tldr; do
  sudo apt-get install -y "$pkg" || echo "skip: $pkg not available"
done

if ! command -v fastfetch >/dev/null 2>&1; then
  echo "==> Installing fastfetch (not in apt)"
  ARCH=$(dpkg --print-architecture)
  TMP=$(mktemp)
  curl -fsSL -o "$TMP" "https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-${ARCH}.deb"
  sudo dpkg -i "$TMP"
  rm -f "$TMP"
fi

echo "==> Cloning zsh plugins into oh-my-zsh custom"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
mkdir -p "$ZSH_CUSTOM"
declare -A plugins=(
  [zsh-autosuggestions]=https://github.com/zsh-users/zsh-autosuggestions
  [zsh-completions]=https://github.com/zsh-users/zsh-completions
  [zsh-history-substring-search]=https://github.com/zsh-users/zsh-history-substring-search
  [fast-syntax-highlighting]=https://github.com/zdharma-continuum/fast-syntax-highlighting
)
for name in "${!plugins[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/$name" ]; then
    git clone --depth=1 "${plugins[$name]}" "$ZSH_CUSTOM/$name"
  else
    echo "skip: $name already present"
  fi
done

echo "==> Linking .zshrc"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d-%H%M%S)"
cp "$(dirname "$0")/.zshrc" "$HOME/.zshrc"

echo "==> Done. Run: exec zsh"
echo "Note: for eza icons, install a Nerd Font and set it as your terminal font (not done automatically)."
