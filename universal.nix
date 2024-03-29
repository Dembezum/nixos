{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
# Networking tools
      wget
      dnsutils
      nmap
      socat
      screen
      tcpdump

# System utilities
      inxi
      lsb-release
      neofetch
      tree
      which
      pciutils
      usbutils
      lm_sensors
      git

# QOL
      fzf
      xclip
      eza
      bat
      fd

# File systems
      ntfs3g
      exfat
      exfatprogs
      sshfs-fuse

# Process management
      ripgrep
      killall
      htop
      btop
      parted
      fuse

# Disk management
      sdparm
      hdparm
      gptfdisk
      ncdu

# Archive management
      gnutar
      unzip
      zip

# Termianl Stuff
      kitty
      tmux

# Text manipulation / editing
      vim
      shellcheck

# System recovery and management
      efibootmgr # EFI boot manager
      efivar # EFI variable manager
      ];

#xdg.portal = { enable = true; extraPortals = [ 
#pkgs.xdg-desktop-portal-gtk
#]; };

# Show chnages in the system configuration
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
      /run/current-system "$systemConfig"
      '';
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
# Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

# Configure the system to use danish locale settings
  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_DK.UTF-8";
  console.keyMap = "dk-latin1";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

}

