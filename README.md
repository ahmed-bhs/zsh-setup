# zsh-setup

My zsh config: oh-my-zsh + spaceship prompt + fzf/zoxide/eza/bat/fd + fast syntax highlighting + history substring search.

## Install

```bash
git clone https://github.com/ahmed-bhs/zsh-setup.git
cd zsh-setup
./install.sh
exec zsh
```

Requires oh-my-zsh already installed (`https://ohmyz.sh`).

## What's in it

- **Prompt**: spaceship
- **Plugins**: git, docker, docker-compose, kubectl, composer, symfony, fzf, zsh-autosuggestions, fast-syntax-highlighting, zsh-history-substring-search, zsh-completions, colored-man-pages, extract, sudo
- **CLI tools**: fzf, zoxide (`z`), eza (`ls`/`ll`/`la`/`lt`), bat (`cat`), fd, btop (`top`), duf (`df`), tldr, fastfetch
- **Shortcuts**: `cheat` or `?` shows a cheatsheet on every new terminal
- **NVM**: lazy-loaded for fast startup

## Optional: icons

`eza` icons need a Nerd Font set as your terminal font. Not configured automatically — install one (e.g. FiraCode Nerd Font) and set it in your terminal preferences if you want icons in `ll`/`la`/`lt`.
