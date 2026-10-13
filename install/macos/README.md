# Key remapping

Run once as your normal user (without sudo), from any directory:

```sh
/path/to/dotfiles/install/macos/keybindings.sh
```

The installer applies these mappings immediately through a user LaunchAgent
and reapplies them at each graphical login, including after a restart:

| Key | Remapped key |
| --- | --- |
| Caps Lock | F18 |
| Spotlight/Search | F13 |
| Dictation | F19 |

Keep F18 assigned to input-source switching in System Settings → Keyboard →
Keyboard Shortcuts → Input Sources. The agent only remaps keys; it does not
configure those shortcuts.

All three mappings live in `com.local.KeyRemapping.plist`, which runs
`/usr/bin/hidutil` directly. No separate remapping script is needed.
The installer fills in the log paths and installs the plist under
`~/Library/LaunchAgents/com.local.KeyRemapping.plist`.
Startup does not depend on the repository staying in the same location.
Rerun the installer after editing the plist's mappings; reinstalling replaces
the existing job. Do not copy the template plist directly into LaunchAgents.

## Check startup

```sh
launchctl print "gui/$(id -u)/com.local.KeyRemapping"
/usr/bin/hidutil property --get UserKeyMapping
cat "$HOME/Library/Logs/KeyRemapping/stderr.log"
cat "$HOME/Library/Logs/KeyRemapping/stdout.log"
```

A successful one-shot job can show `state = not running` with
`last exit code = 0`. It does not need to remain running for mappings to work.
After a restart, check the mapping and test all three physical keys.

If the job succeeds but keys are unaffected, check System Settings → Privacy &
Security → Input Monitoring. On recent macOS versions, `hidutil` may need its
own permission even if remapping already works from Terminal. Add
`/usr/bin/hidutil` using the + button (Command-Shift-G opens the path prompt),
enable it, then rerun the installer.

To reapply through the installed agent:

```sh
launchctl kickstart "gui/$(id -u)/com.local.KeyRemapping"
```

This job runs once per login. macOS can also clear mappings when the last
keyboard disconnects. If mappings disappear after reconnecting a keyboard or
waking, check the logs and mapping state before adding retries or a recurring
job.

## Uninstall

```sh
launchctl bootout "gui/$(id -u)/com.local.KeyRemapping"
rm "$HOME/Library/LaunchAgents/com.local.KeyRemapping.plist"
```

The current mappings remain until restart, or until explicitly cleared with
`/usr/bin/hidutil property --set '{"UserKeyMapping":[]}'`. Clearing this property
also removes any mappings another tool configured through `hidutil`.
