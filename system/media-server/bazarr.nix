{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.bazarr = {
      enable = true;
      openFirewall = true;
      package = pkgs-unstable.bazarr;
    };
    services.caddy.virtualHosts."bazarr.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
      reverse_proxy http://127.0.0.1:6767
      '';
    };
  };
}
