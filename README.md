# My NixOS Flake Configuration

## Overview

This repository contains a NixOS flake configuration designed for use with
`home-manager`. It aims to provide a reproducible and declarative setup for a
NixOS system with home-manager user environments.

> Note that this is very much a Work In Progress. Things might not work as
> intended.

## Structure

The flake is organized into several directories, each serving a specific purpose:

- `configuration.nix`: The main system configuration file.
- `hardware-configuration.nix`: Specific configurations for the system hardware.
- `flake.nix`: The entry point for the flake, including definitions of inputs and outputs.
- `system/`: Contains system-level modules like `bluetooth`, `networking`, `pipewire`, `X11`, etc.
- `user/`: Contains user-level configurations and modules such as `gnome`, `kde`, `neovim`, and more.

> Not every module is configured yet, but i'm working on it!

## Usage

To use this flake, you need to have Nix with flakes support enabled.

### Building the System

To build the NixOS configuration:

```bash
sudo nixos-rebuild switch --flake .#myNixOS
```

### Managing Home Manager

To apply `home-manager` configurations:

```bash
home-manager switch --flake .#nixtop
```

## Modules

This configuration includes a variety of modules to set up different aspects of
the system:

- **Audio**: Managed by `pipewire` with support for both ALSA and PulseAudio.
- **Display**: X11 and potentially others based on the system setup.
- **Networking**: Includes configurations for network interfaces and firewall.
- **User Environments**: Home manager is used to manage user-specific configurations for applications like `kitty`, `neovim`, `tmux`, etc.

## User Configuration

The user `nixtop` is predefined with home-manager enabled. The home directory
and various programs such as `git` are configured in `nixtop's home.nix`.

## Contributing

Contributions to this flake are welcome. Feel free to fork the project, make
your changes, and submit a pull request.

## License

Feel free to use as you please. 
