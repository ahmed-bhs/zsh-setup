# zsh-setup

My zsh config: oh-my-zsh + spaceship prompt + fzf/zoxide/eza/bat/fd + fast syntax highlighting + history substring search.

## New machine setup

```bash
git clone https://github.com/ahmed-bhs/zsh-setup.git
cd zsh-setup
./install.sh
```

`install.sh` is idempotent (safe to re-run) and does, in order:

1. Install `zsh git curl` via apt
2. Install oh-my-zsh if missing
3. Install spaceship prompt theme into oh-my-zsh custom themes
4. Install CLI tools via apt: `fzf zoxide bat eza fd-find btop duf tldr`
5. Install `fastfetch` (downloaded from GitHub releases, not in apt)
6. Clone zsh plugins into oh-my-zsh custom plugins:
   - `zsh-autosuggestions`
   - `zsh-completions`
   - `zsh-history-substring-search`
   - `fast-syntax-highlighting`
7. Install `nvm` if missing
8. Backup any existing `~/.zshrc` (timestamped) and install this repo's `.zshrc`
9. Set zsh as default login shell (`chsh`)

After install, log out/in or run `exec zsh`.

## What's in `.zshrc`

- **Prompt**: spaceship
- **Plugins**: git, docker, docker-compose, kubectl, composer, symfony, heroku, pip, lein, command-not-found, colored-man-pages, extract, sudo, fzf, zsh-completions, zsh-autosuggestions, fast-syntax-highlighting, zsh-history-substring-search
- **CLI tools**:
  - `fzf` — Ctrl+R fuzzy history, Ctrl+T fuzzy file picker, Alt+C fuzzy cd
  - `zoxide` — `z <dir>` / `zi` smart cd
  - `eza` — `ls` / `ll` / `la` / `lt` (git-aware listing)
  - `bat` (as `batcat`) — colorized `cat`
  - `fd` (as `fdfind`) — fast find
  - `btop` — `top` replacement
  - `duf` — `df` replacement
  - `tldr` — short command examples
  - `fastfetch` — system info banner on shell start
- **nvm** — lazy-loaded, only initializes on first `node`/`npm`/`npx`/`nvm` call
- **History** — 50k entries, deduped, shared across sessions
- **Cheatsheet** — `cheat` or `?` prints all shortcuts; shown automatically on every new terminal

## Optional: icons

`eza` icons need a Nerd Font set as your terminal font. Not configured automatically — install one (e.g. FiraCode Nerd Font) and set it in your terminal preferences if you want icons in `ll`/`la`/`lt`.

## Manual steps not automated

- Terminal font / Nerd Font (cosmetic, user choice)
- PHP, Composer, Symfony CLI, Docker, kubectl, Flutter, Platform.sh CLI — assumed already present if you use those plugins; install separately per your project needs
