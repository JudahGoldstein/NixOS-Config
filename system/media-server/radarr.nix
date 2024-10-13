{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.radarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/radarr";
    };
    services.caddy.virtualHosts."radarr.janjuta.duckdns.org".extraConfig = ''
      reverse_proxy http://127.0.0.1:7878
      tls /var/lib/acme/janjuta.duckdns.org/cert.pem /var/lib/acme/janjuta.duckdns.org/key.pem {
        protocols tls1.3
      }
    '';
  };
}
