{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
    vim
    htop
    git
    neofetch
    zip
    unzip
    ripgrep
    eza
    fzf
    dnsutils
    nmap
    gnutar
    tree
    which
    pciutils
    usbutils
    lm_sensors
    btop
    testdisk # useful for repairing boot problems
    ms-sys # for writing Microsoft boot sectors / MBRs
    efibootmgr
    efivar
    parted
    gptfdisk
    fuse
    fuse3
    sshfs-fuse
    socat
    screen
    tcpdump
    sdparm
    hdparm
    smartmontools # for diagnosing hard disks
    nvme-cli
    kitty
    xclip
    ncdu
    tmux
  ];
}

