{ pkgs, config, ... }:
{
  services.mediawiki = {
    enable = true;
    name = "ZumWiki";
    httpd.virtualHost = {
      hostName = "nixwiki.zum.local";
      adminAddr = "wiki@admin.local";
    };

# Administrator account username is admin.
    passwordFile = pkgs.writeText "password" "mediawikipass";
    extraConfig = ''
# Disable anonymous editing
      $wgGroupPermissions['*']['edit'] = false;
    '';

    extensions = {
      VisualEditor = null;
    };
  };
}
