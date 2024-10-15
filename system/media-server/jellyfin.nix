{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      cacheDir = "/var/cache/jellyfin";
      dataDir = "/var/lib/jellyfin";
      logDir = "/var/log/jellyfin";
    };

    services.caddy.virtualHosts."jellyfin.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
    services.caddy.virtualHosts."jellyfin.jantun.duckdns.org" = {
      useACMEHost = "jantun.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
  };
}
