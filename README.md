# zsh-setup

My zsh config: oh-my-zsh + spaceship prompt + fzf/zoxide/eza/bat/fd + fast syntax highlighting + history substring search.

## About

Personal dotfiles + a single `install.sh` that bootstraps a fresh Linux machine to my exact shell setup: prompt, plugins, CLI tools, history config, git aliases, and a cheatsheet shown on every new terminal.

<!-- screenshot.png: drop a terminal screenshot here and uncomment
![terminal preview](screenshot.png)
-->


## License

MIT — see [LICENSE](LICENSE).

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
9. Backup and install `~/.gitconfig`, `~/.gitignore_global`, `~/.czrc` from `config/`
10. Set zsh as default login shell (`chsh`)

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

## Other configs included

- `config/.gitconfig` — git aliases (`co`, `ci`, `st`, `br`, `wip`), user identity, meld merge tool, gh credential helper
- `config/.gitignore_global` — global ignore (`.idea/`, `.claude/`)
- `config/.czrc` — commitizen conventional-changelog config
- `config/phpstorm-keymap.xml` — custom PhpStorm keymap (import manually via Settings > Keymap > Import Keymap). PhpStorm itself uses **Settings Sync** (JetBrains account), not this repo.
- `config/fastfetch/config.jsonc` — fastfetch module list (excludes Local IP and Battery, shown on every new terminal)

## References

### oh-my-zsh & theme
- oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh
- spaceship prompt: https://github.com/denysdovhan/spaceship-prompt

### zsh plugins
- zsh-autosuggestions: https://github.com/zsh-users/zsh-autosuggestions
- zsh-completions: https://github.com/zsh-users/zsh-completions
- zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
- fast-syntax-highlighting: https://github.com/zdharma-continuum/fast-syntax-highlighting

### oh-my-zsh built-in plugins used
git, docker, docker-compose, kubectl, composer, symfony, heroku, pip, lein, command-not-found, colored-man-pages, extract, sudo, fzf — all from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins

### CLI tools
- fzf: https://github.com/junegunn/fzf
- zoxide: https://github.com/ajeetdsouza/zoxide
- eza: https://github.com/eza-community/eza
- bat: https://github.com/sharkdp/bat
- fd: https://github.com/sharkdp/fd
- btop: https://github.com/aristocratos/btop
- duf: https://github.com/muesli/duf
- tldr (tldr-hs): https://github.com/tldr-pages/tldr
- fastfetch: https://github.com/fastfetch-cli/fastfetch
- nvm: https://github.com/nvm-sh/nvm

## Optional: icons

`eza` icons need a Nerd Font set as your terminal font. Not configured automatically — install one (e.g. FiraCode Nerd Font) and set it in your terminal preferences if you want icons in `ll`/`la`/`lt`.

## Manual steps not automated

- Terminal font / Nerd Font (cosmetic, user choice)
- PHP, Composer, Symfony CLI, Docker, kubectl, Flutter, Platform.sh CLI — assumed already present if you use those plugins; install separately per your project needs
