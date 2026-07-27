#!/usr/bin/env bash
# Bootstrap portable Sway/foot/waybar + vim/zsh dotfiles onto this machine.
# Usage (from a clone of this repo):
#   ./install.sh              # link configs + helpers
#   ./install.sh --packages   # also apt-install packages.txt (needs sudo)
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINK_ROOT="${REPO}/link"
PACKAGES_FILE="${REPO}/packages.txt"
INSTALL_PACKAGES=0

for arg in "$@"; do
  case "$arg" in
    --packages|-p) INSTALL_PACKAGES=1 ;;
    --help|-h)
      cat <<EOF
Usage: ./install.sh [--packages]

  Links desktop + shell/editor configs from link/ into \$HOME.
  Clones oh-my-zsh into ~/.oh-my-zsh if missing, then links custom plugins.
  Existing regular files/dirs are backed up as *.bak.<timestamp>.

  --packages   Run: sudo apt install \$(cat packages.txt)
EOF
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

ts="$(date +%Y%m%d%H%M%S)"

link_path() {
  local rel="$1"
  local src="${LINK_ROOT}/${rel}"
  local dst="${HOME}/${rel}"

  if [[ ! -e "$src" && ! -L "$src" ]]; then
    echo "skip missing: $rel" >&2
    return
  fi

  mkdir -p "$(dirname "$dst")"

  if [[ -L "$dst" ]]; then
    local target
    target="$(readlink "$dst")"
    if [[ "$target" == "$src" ]]; then
      echo "ok   $rel"
      return
    fi
    rm -f "$dst"
  elif [[ -e "$dst" ]]; then
    mv "$dst" "${dst}.bak.${ts}"
    echo "bak  $rel -> ${rel}.bak.${ts}"
  fi

  ln -s "$src" "$dst"
  echo "link $rel"
}

ensure_oh_my_zsh() {
  local omz="${HOME}/.oh-my-zsh"
  if [[ -L "$omz" ]]; then
    echo "note: ~/.oh-my-zsh is a symlink — not replacing it"
    return
  fi
  if [[ -f "${omz}/oh-my-zsh.sh" ]]; then
    echo "ok   oh-my-zsh (already present)"
    return
  fi
  if [[ -e "$omz" ]]; then
    mv "$omz" "${omz}.bak.${ts}"
    echo "bak  .oh-my-zsh -> .oh-my-zsh.bak.${ts}"
  fi
  echo "clone oh-my-zsh..."
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$omz"
}

echo "Repo: $REPO"
echo "Home: $HOME"
echo

ensure_oh_my_zsh
echo

# Whole trees / files under link/ (directories become one symlink each)
ENTRIES=(
  .zshrc
  .vimrc
  .zsh
  .vim
  bin
  .config/sway
  .config/foot
  .config/waybar
  .config/fuzzel
  .config/mako
  .config/environment.d
  .local/share/applications/microsoft-teams.desktop
  .local/share/applications/teams-for-linux.desktop
  .oh-my-zsh/custom/plugins/zsh-autosuggestions
  .oh-my-zsh/custom/plugins/zsh-completions
)

for rel in "${ENTRIES[@]}"; do
  link_path "$rel"
done

chmod +x "${LINK_ROOT}/bin/"* 2>/dev/null || true

# PATH for this login (environment.d applies on next login/session)
if ! grep -q '\$HOME/bin' "${HOME}/.profile" 2>/dev/null; then
  cat >> "${HOME}/.profile" <<'EOF'

# dotfiles install.sh — user binaries
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi
EOF
  echo "note appended PATH snippet to ~/.profile"
fi

if [[ "$INSTALL_PACKAGES" -eq 1 ]]; then
  if [[ ! -f "$PACKAGES_FILE" ]]; then
    echo "Missing $PACKAGES_FILE" >&2
    exit 1
  fi
  mapfile -t pkgs < <(grep -vE '^\s*(#|$)' "$PACKAGES_FILE")
  echo
  echo "Installing packages (${#pkgs[@]}) with apt (sudo)..."
  sudo apt-get update
  sudo apt-get install -y "${pkgs[@]}"
fi

if command -v update-desktop-database >/dev/null; then
  update-desktop-database "${HOME}/.local/share/applications" 2>/dev/null || true
fi

cat <<EOF

Done.

Next:
  1. Log out and choose the Sway session (or: swaymsg reload if already in Sway)
  2. Open a new terminal to pick up linked ~/.zshrc
  3. Optional extras on a fresh machine:
       # Teams (Electron): sudo apt install teams-for-linux   # after adding its repo
       # Cursor apt repo:   sudo ~/bin/enable-cursor-apt-updates.sh   # if you keep that script
       # ThinkPad volume Fn keys (X1 Carbon):
       #   sudo ~/bin/thinkpad-enable-volume-keys
       #   # persist: sudo apt install sysfsutils
       #   #          sudo cp ${REPO}/link/sysfs.d/thinkpad-volume-keys.conf /etc/sysfs.d/
       #   #          sudo systemctl restart sysfsutils

Wallpaper is linked to ~/.config/sway/wallpaper (replace that file to change it).

EOF
