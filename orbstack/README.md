# OrbStack

OrbStack provides the Docker engine, Docker CLI, Compose, and Buildx on macOS. It is installed with the other apps in `brew/Brewfile`:

```sh
./brew/install.sh
```

To install only OrbStack, run `brew install --cask orbstack`.

## First use on a new Mac

1. Open OrbStack once to finish setup, or run `orb start` from the terminal.
2. Check that Docker is using OrbStack:

   ```sh
   docker context ls
   docker info
   ```

3. If another Docker engine is selected, switch to OrbStack:

   ```sh
   docker context use orbstack
   ```

Use `docker`, `docker compose`, and `docker buildx` normally after that. `orb stop` stops OrbStack.

## Moving from Docker Desktop

Stop Docker Desktop before using OrbStack to avoid running both engines. OrbStack offers to copy containers, images, and volumes on first launch. You can also migrate later with:

```sh
orb docker migrate
```

If Docker Desktop's CLI is already installed, OrbStack leaves it in place. OrbStack's Docker CLI lives in `~/.orbstack/bin`; remove the old CLI only if you want OrbStack to provide the commands, then restart OrbStack. Check `command -v docker` before changing anything. The Docker context controls which engine the CLI uses, even when another CLI is installed.

See the [OrbStack installation guide](https://docs.orbstack.dev/install) and [command line guide](https://docs.orbstack.dev/headless) for current details.
