{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.readarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/readarr";
    };
    services.caddy.virtualHosts."readarr.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8787
        tls /var/lib/acme/janjuta.duckdns.org/cert.pem /var/lib/acme/janjuta.duckdns.org/key.pem {
          protocols tls1.3
        }
      '';
    };
  };
}
