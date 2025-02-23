{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
      package = pkgs-unstable.prowlarr;
    };
    services.caddy.virtualHosts."prowlarr.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:9696
      '';
    };
  };
}
