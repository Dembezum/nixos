{ pkgs, config, ... }:
{
services.mediawiki = {
  enable = true;
  name = "ZumWiki";
  httpd.virtualHost = {
    hostName = "nixwiki.local";
    adminAddr = "wiki@admin.local";
  };

  # Administrator account username is admin.
  passwordFile = pkgs.writeText "password" "medpass";
  extraConfig = ''
    # Disable anonymous editing
    $wgGroupPermissions['*']['edit'] = false;
  '';

  extensions = {
    VisualEditor = null;
  };
};

services.mediawiki.httpd.virtualHost.listen = [
  {
    ip = "192.168.1.3";
    port = 8080;
    ssl = false;
  }
];
}
