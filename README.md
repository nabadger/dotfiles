# Dotfiles (Sway / Wayland)

No yadm required. Clone, run `./install.sh`, done.

## On a new Ubuntu 26.04 laptop

```bash
git clone <this-repo> ~/src/github/me/dotfiles
cd ~/src/github/me/dotfiles
git checkout wayland_sway   # or main, once merged
./install.sh --packages
```

Then log out → login screen gear → **Sway**. Open a new terminal for zsh.

## What it does

- Symlinks everything under `link/` into `$HOME` (desktop, vim, zsh, `~/bin`)
- Clones [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) into `~/.oh-my-zsh` if missing
- Links custom plugins (`zsh-autosuggestions`, `zsh-completions`) into OMZ
- Backs up colliding files/dirs to `*.bak.<timestamp>`
- With `--packages`, installs `packages.txt` via apt

## Layout

```text
install.sh
packages.txt
link/
  .zshrc
  .vimrc
  .zsh/
  .vim/
  .oh-my-zsh/custom/plugins/   # only custom plugins; core is cloned
  .config/sway|foot|waybar|fuzzel|mako|environment.d/
  .local/share/applications/   # Teams launcher
  bin/                         # portable helpers
```

## Secrets

Do **not** commit credentials. This tree has no SSH keys, AWS creds, browser profiles, or Cursor/Teams session data.

Ignored examples (see `.gitignore`): `.ssh`, `.gnupg`, shell history, etc.

## Optional apps

- **Teams**: install `teams-for-linux` separately, then the linked desktop file launches `~/bin/teams`
- **Cursor**: enable its apt repo yourself if you want; not required for Sway

## Wallpaper

Linked from `link/.config/sway/wallpaper`. Replace that file (same name) to change the background.
