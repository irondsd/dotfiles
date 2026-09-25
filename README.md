# Dotfiles

My macOS apps, shell config, and setup scripts. On a new Mac:

1. Install [Homebrew](https://brew.sh/) and follow its instructions to add `brew` to your shell's PATH.

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. Clone this repo and run the setup scripts:

   ```sh
   mkdir -p ~/dev
   git clone https://github.com/irondsd/dotfiles.git ~/dev/dotfiles
   cd ~/dev/dotfiles
   bash brew/install.sh
   bash install/bootstrap.sh
   bash zsh/prepare.sh
   ```

3. Open a new terminal, then install Node.js LTS with `fnm`. npm comes with Node.js; Bun was installed from the Brewfile.

   ```sh
   fnm install --lts
   fnm use lts/latest
   node --version
   npm --version
   bun --version
   ```

4. Open OrbStack, finish its first-run setup, then select its Docker context:

   ```sh
   open -a OrbStack
   # After OrbStack is ready:
   docker context use orbstack
   ```

   See [OrbStack setup](orbstack/README.md) if moving data from Docker Desktop.

Optional personal setup:

```sh
bash install/macos/defaults.sh
```

After importing my GPG key and setting up GitHub SSH access, run `bash pass/init.sh` to restore the password store. The other scripts in `install/macos/` set my machine name and keyboard remapping when needed.
