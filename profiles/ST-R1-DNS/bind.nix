{ ... }: 

let
  ipv4 = "172.16.0.22";
  fqdn2domain = "tts.local";
in {

  system.activationScripts.bind-zones.text = ''
    mkdir -p /etc/bind/zones
    chown named:named /etc/bind/zones
  '';

  environment.etc."bind/zones/${fqdn2domain}.zone" = {
    enable = true;
    user = "named";
    group = "named";
    mode = "0644";
    text = ''
$ORIGIN .
$TTL 60 ; 1 minute
${fqdn2domain} IN SOA ns1.${fqdn2domain}. tts.local. (
      1          ; serial
      21600      ; refresh (6 hours)
      3600       ; retry (1 hour)
      604800     ; expire (1 week)
      86400      ; minimum (1 day)
)

NS                                  ns1.${fqdn2domain}.
$ORIGIN                             ${fqdn2domain}.
${fqdn2domain}.             A       ${ipv4}
ns1                         A       ${ipv4}
prox.${fqdn2domain}.        A       172.16.0.10
nixdhcp.${fqdn2domain}.     A       172.16.0.22
nixvpn.${fqdn2domain}.      A       172.16.0.20
'';
  };

  services.bind = {
    enable = true;
    extraConfig = ''
    '';
    zones = [
      {
        name = fqdn2domain;
        allowQuery = ["any"];
        file = "/etc/bind/zones/${fqdn2domain}.zone";
        master = true;
      }
    ];
  };
}
