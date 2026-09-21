#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

brew bundle --no-upgrade --file="$SCRIPT_DIR/Brewfile"
