{ pkgs, ... }: {

  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    binutils
    qmk
    avrdude
    dfu-util
    dfu-programmer
    qmk-udev-rules
    python3
    vial

  ];

  services.udev.packages = with pkgs; [
    vial
    qmk
    qmk-udev-rules
    avrdude
    dfu-util
    dfu-programmer

  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="input", GROUP="input", MODE="0666"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939[0-7]", MODE:="0666", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939[0-7]", MODE="0666"

    # Grant Vial access to all HID USB devices!
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl


    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess", TAG+="udev-acl", GROUP="input"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", TAG+="uaccess", TAG+="udev-acl", GROUP="users"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="342d", ATTRS{idProduct}=="dfa0", TAG+="uaccess"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="c2ab", ATTRS{idProduct}=="3939", TAG+="uaccess"

  '';
}
