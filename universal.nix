{ userSettings, systemSettings, pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    # -- NETWORKING TOOLS --
    whois
    iperf3
    wget
    dnsutils
    nmap
    socat
    tcpdump
    sshfs-fuse
    nfs-utils
    localsend

    # -- SYSTEM UTILITIES --
    screen
    tree
    which
    glances
    powertop
    pciutils
    usbutils
    neofetch
    lm_sensors
    lsb-release
    inxi
    kmon

    # -- DEVELOPMENT TOOLS --
    git
    vim
    shellcheck
    fzf

    # -- FILE MANAGEMENT --
    eza
    bat
    fd
    ntfs3g
    exfat
    exfatprogs
    unzip
    zip
    gnutar
    ncdu
    ripgrep

    # -- SYSTEM MANAGEMENT --
    killall
    htop
    btop
    parted
    fuse
    procs
    gparted
    gnome-disk-utility
    du-dust
    duf
    sdparm
    hdparm
    gptfdisk

    # -- TERMINAL UTILITIES --
    kitty
    tmux
    xclip

    # -- BOOT MANAGEMENT --
    efibootmgr
    efivar

    # -- MISCELLANEOUS UTILITIES --
    feh
    eva
    nh
    nvd
  ];

  # -- FONTS --
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
  nix = {
    settings = { auto-optimise-store = true; };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # -- Nix Enviornment --
  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  environment.localBinInPath = true;

  environment.sessionVariables = rec {
    FLAKE = "/home/${userSettings.username}/Git/flakes/nixos";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [ "${XDG_BIN_HOME}" ];
  };
  # Set the hostname
  networking.hostName = systemSettings.hostname;

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
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    #    LC_NUMERIC = "da_DK.UTF-8";
    #    LC_TIME = "da_DK.UTF-8";
  };

  # -- Uncomment for Virtual machines --
  # boot.loader.grub = {
  #    enable = true;
  #    device = "/dev/sda";
  #    useOSProber = true;
  #  };
}
