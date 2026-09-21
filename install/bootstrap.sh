#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.." || exit 1
DOTFILES=$(pwd -P)

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] %b\n" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n\n" "$1" >&2
  exit 1
}

link_file () {
  local src=$1 dst=$2

  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      # ignoring exit 1 from readlink in case where file already exists
      # shellcheck disable=SC2155
      local currentSrc
      currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action  < /dev/tty

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf -- "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$src" "$dst"
    success "linked $1 to $2"
  fi
}

expand_link_path () {
  case "$1" in
    '$DOTFILES/'*)
      printf '%s/%s\n' "$DOTFILES" "${1#\$DOTFILES/}"
      ;;
    '$HOME/'*)
      printf '%s/%s\n' "$HOME" "${1#\$HOME/}"
      ;;
    *)
      fail "unsupported path in links.prop: $1"
      ;;
  esac
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  while IFS= read -r linkfile
  do
    while IFS='=' read -r src_template dst_template
    do
        local src dst dir
        src=$(expand_link_path "$src_template")
        dst=$(expand_link_path "$dst_template")
        dir=$(dirname "$dst")

        case "$src" in
          "$DOTFILES"/*) ;;
          *) fail "link source is outside the dotfiles repo: $src" ;;
        esac

        case "$dst" in
          "$HOME"/*) ;;
          *) fail "link destination is outside the home directory: $dst" ;;
        esac

        mkdir -p "$dir"
        link_file "$src" "$dst"
    done < "$linkfile"
  done < <(find -H "$DOTFILES" -maxdepth 2 -name 'links.prop' -not -path '*.git*')
}

install_zsh_edit_select () {
    local plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-edit-select"

    if [ -f "$plugin_dir/zsh-edit-select.plugin.zsh" ]; then
        success 'zsh-edit-select already installed'
        return
    fi

    if [ -e "$plugin_dir" ]; then
        fail "$plugin_dir exists but is not a valid zsh-edit-select installation"
    fi

    mkdir -p "$(dirname "$plugin_dir")"
    git clone --depth=1 \
      https://github.com/Michael-Matta1/zsh-edit-select.git \
      "$plugin_dir"
    success 'installed zsh-edit-select'
}

install_dotfiles
install_zsh_edit_select

echo ''
echo ''
success 'All installed!'
