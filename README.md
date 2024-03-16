# My NixOS Flake Configuration

## Overview

This repository contains my NixOS flake configuration designed for use with
`home-manager`. It aims to provide a reproducible, modular and declarative setup
for a NixOS system with home-manager user environments.

## Table of Contents

1. [Overview](#overview)
2. [Structure](#structure)
   - [2.1 flake.nix](#structure)
   - [2.2 Profiles Directory](#structure)
   - [2.3 System Directory](#structure)
   - [2.4 User Directory](#structure)
3. [Usage](#usage)
   - [3.1 Building the System](#usage)
   - [3.2 Managing Home Manager](#usage)
4. [Modules](#modules)
   - [4.1 Audio](#modules)
   - [4.2 Display](#modules)
   - [4.3 Networking](#modules)
   - [4.4 User Environments](#modules)
5. [User Configuration](#user-configuration)
6. [Contributing](#contributing)
7. [License](#license)


## Structure

The flake is organized into several directories, each serving a specific purpose:

- `flake.nix`: The entry point for the flake, including definitions of inputs and outputs.
- `./profiles/`: Contains the configurations for each system essentially a different machine including `home.nix`, `configuration.nix`, and `hardware-configuration.nix`.
- `./system/`: Contains system-level modules like `bluetooth`, `networking`, `pipewire`, `virtualization`, etc.
- `./user/`: Contains user-level configurations and modules such as `gnome`, `tmux`, `neovim`, and more.

> Not every module is configured yet, but i'm working on it!

## Usage

To use this flake, you need to have Nix with [flakes](https://nixos.wiki/wiki/Flakes) enabled. You will
also make sure to generate a hardware-config.nix and replace it with the one in 
the flake. The beauty is that you can decide what you want included in the build by 
just en -disabling the modules in the `configuration.nix`, and `home.nix`.

You will want to install [home-mnager](https://nix-community.github.io/home-manager/) as well.

### Building the System

To build the NixOS configuration:

```bash
sudo nixos-rebuild switch --flake .#system
```

### Managing Home Manager

To apply `home-manager` configurations:

```bash
home-manager switch --flake .#user
```

## Modules

This configuration includes a variety of modules to set up different aspects of
the system here are some examples:

- **Audio**: Managed by `pipewire` with support for both ALSA and PulseAudio.
- **Display**: X11 and potentially others based on the system setup.
- **Networking**: Includes configurations for network interfaces and firewall.
- **User Environments**: Home manager is used to manage user-specific configurations for applications like `kitty`, `neovim`, `tmux`, etc.

## User Configuration

The user `nixtop` is predefined with home-manager enabled. The home directory
and various programs such as `git` are configured in `./profiles/nixtop/home.nix`.

> If you desire another username/hostname etc, you edit the variable in `flake.nix`,
> this will change the entire configuration to match it.

## Contributing

Contributions to this flake are welcome. Feel free to fork the project, make
your changes, and submit a pull request.

## License

Feel free to do as you please.
