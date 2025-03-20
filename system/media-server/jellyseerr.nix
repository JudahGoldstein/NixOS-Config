{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.jellyseerr = {
      enable = true;
      port = 5055;
      openFirewall = true;
    };
    services.caddy.virtualHosts."jellyseerr.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5055
      '';
    };
    services.caddy.virtualHosts."jellyseerr.wan.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5055
      '';
    };
    services.caddy.virtualHosts."jellyseerr.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:5055
      '';
    };
  };
}
