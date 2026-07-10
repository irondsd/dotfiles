#!/usr/bin/env bash
#
# prepare.sh — adopt this machine's zsh env files into the repo.
#
# For each file listed below it will:
#   1. move an existing real ~/<file> into the repo (zsh/<file>), then
#   2. symlink ~/<file> back to that repo copy.
#
# These files are gitignored, so they stay machine-local while remaining
# editable from inside the repo. Safe to re-run and never deletes data:
# it only moves files or makes backups.

cd "$(dirname "$0")/.." || exit 1
DOTFILES="$(pwd -P)"

# Files to adopt. Add more here if you want the same treatment.
FILES=(.zprofile .zshenv)

# --- pretty output (matches install/bootstrap.sh) ---
info ()    { printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"; }
success () { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"; }
warn ()    { printf "\r\033[2K  [\033[0;33mWARN\033[0m] %s\n" "$1"; }

link_env () {
  local name="$1"
  local repo="$DOTFILES/zsh/$name"
  local home="$HOME/$name"

  # Already a symlink — decide based on where it points.
  if [ -L "$home" ]; then
    if [ "$(readlink "$home")" = "$repo" ]; then
      success "$name already linked"
    else
      warn "$name points elsewhere ($(readlink "$home")) — leaving it alone"
    fi
    return
  fi

  # A real file exists at ~/<name>.
  if [ -e "$home" ]; then
    if [ -e "$repo" ]; then
      # Repo already has a copy; don't clobber it. Back up the home version.
      mv "$home" "$home.backup"
      warn "$name already in repo; backed up your copy to ~/$name.backup"
    else
      mkdir -p "$DOTFILES/zsh"
      mv "$home" "$repo"
      success "moved ~/$name into repo"
    fi
  else
    # No file at home. Make sure a repo copy exists so the link resolves.
    if [ ! -e "$repo" ]; then
      mkdir -p "$DOTFILES/zsh"
      : > "$repo"
      info "created empty zsh/$name"
    fi
  fi

  ln -s "$repo" "$home"
  success "linked ~/$name -> zsh/$name"
}

echo
for f in "${FILES[@]}"; do
  link_env "$f"
done
echo
success "zsh env prepared"
