{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        extraConfig = ''
          [ids]
          *

          [main]
          capslock = enter
        '';

      };
    };
  };
}
