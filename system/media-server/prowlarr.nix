{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
    services.caddy.virtualHosts."prowlarr.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9696
      '';
    };
    services.caddy.virtualHosts."prowlarr.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9696
      '';
    };
  };
}
