{ config, pkgs, ...}:

{

 services.librenms = {
    enable = true;
    dataDir = "/var/lib/librenms";
    logDir = "/var/log/librenms";
    hostname = "librenms.zum.local";
    user = "librenms";
    group = "librenms";
    settings = {
      "db_host" = "localhost";
      "db_user" = "librenms";
      "db_pass" = "your_password";
      "db_name" = "librenms";
    };
    nginx = {
      enable = true;
      virtualHost = {
        server_name = "nixweb.zum.local";
        root = "/var/lib/librenms/html";
        listen = [ { port = 80; } ];
        location = {
          "/".index = "index.php";
          "/".try_files = "$uri $uri/ =404";
          "~ \.php$".fastcgi_pass = "unix:/run/php-fpm/www.sock";
          "~ \.php$".fastcgi_index = "index.php";
          "~ \.php$".include = "fastcgi.conf";
        };
      };
    };
    database = {
      enable = true;
      user = "librenms";
      password = "your_password";
      name = "librenms";
    };
  };

  };
