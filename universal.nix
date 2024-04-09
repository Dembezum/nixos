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
      git
      kmon
      inxi
      tree
      which
      glances
      pciutils
      usbutils
      neofetch
      lm_sensors
      lsb-release
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
      gnome.gnome-disk-utility
      du-dust
      duf
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
      efibootmgr
      efivar
      ];

# -- FONTS --
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = [ "JetBrainsMono" ];})
      font-awesome
      material-design-icons
  ];


# Show chnages in the system configuration
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff \
      /run/current-system "$systemConfig"
      '';
  };

# -- NIX OPTIONS --
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";

  };

  nixpkgs.config.allowUnfree = true;

# -- Nix Enviornment --
  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  environment.localBinInPath = true;

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

