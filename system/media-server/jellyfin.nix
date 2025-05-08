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
      package = pkgs.jellyfin;
    };
    services.caddy.virtualHosts."jellyfin.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
    services.caddy.virtualHosts."jellyfin.wan.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
    services.caddy.virtualHosts."jellyfin.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
  };
}
