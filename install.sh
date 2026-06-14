#!/usr/bin/env bash
set -e

echo "==> Installing zsh and git"
sudo apt-get update -qq
sudo apt-get install -y zsh git curl

echo "==> Checking oh-my-zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "==> Checking spaceship prompt theme"
ZSH_THEMES="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
mkdir -p "$ZSH_THEMES"
if [ ! -d "$ZSH_THEMES/spaceship-prompt" ]; then
  git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_THEMES/spaceship-prompt"
fi
ln -sf "$ZSH_THEMES/spaceship-prompt/spaceship.zsh-theme" "$ZSH_THEMES/spaceship.zsh-theme"

echo "==> Installing apt packages"
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

echo "==> Checking nvm"
if [ ! -d "$HOME/.nvm" ]; then
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

echo "==> Installing fastfetch config"
mkdir -p "$HOME/.config/fastfetch"
cp "$(dirname "$0")/config/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "==> Linking .zshrc"
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d-%H%M%S)"
cp "$(dirname "$0")/.zshrc" "$HOME/.zshrc"

echo "==> Linking git config"
DIR="$(dirname "$0")/config"
for f in .gitconfig .gitignore_global .czrc; do
  [ -f "$HOME/$f" ] && cp "$HOME/$f" "$HOME/$f.bak.$(date +%Y%m%d-%H%M%S)"
  cp "$DIR/$f" "$HOME/$f"
done

echo "==> PhpStorm keymap saved at config/phpstorm-keymap.xml"
echo "Import manually: PhpStorm > Settings > Keymap > Import Keymap"

echo "==> Setting zsh as default shell"
if [ "$SHELL" != "$(command -v zsh)" ]; then
  chsh -s "$(command -v zsh)" "$USER"
fi

echo "==> Done. Log out/in (or run: exec zsh) to start using it."
echo "Note: for eza icons, install a Nerd Font and set it as your terminal font (not done automatically)."
