#!/bin/bash
set -euo pipefail

if [[ "$(id -u)" -eq 0 ]]; then
    echo "Run this installer as your normal user, without sudo." >&2
    exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
label="com.local.KeyRemapping"
domain="gui/$(id -u)"
agent_dir="$HOME/Library/LaunchAgents"
log_dir="$HOME/Library/Logs/KeyRemapping"
agent_path="$agent_dir/$label.plist"

mkdir -p "$agent_dir" "$log_dir"
staged_plist="$(mktemp "$agent_dir/.$label.XXXXXX")"
trap 'rm -f "$staged_plist"' EXIT

/usr/bin/install -m 644 "$script_dir/$label.plist" "$staged_plist"
/usr/bin/plutil -replace StandardOutPath -string "$log_dir/stdout.log" "$staged_plist"
/usr/bin/plutil -replace StandardErrorPath -string "$log_dir/stderr.log" "$staged_plist"
/usr/bin/plutil -lint "$staged_plist"

# Unregister an existing job before replacing its definition.
if /bin/launchctl print "$domain/$label" >/dev/null 2>&1; then
    /bin/launchctl bootout "$domain/$label"
fi
mv -f "$staged_plist" "$agent_path"
/bin/launchctl enable "$domain/$label"
/bin/launchctl bootstrap "$domain" "$agent_path"

echo "Installed key remapping for this login and future logins."
echo "Status: launchctl print $domain/$label"
echo "Logs: $log_dir"
