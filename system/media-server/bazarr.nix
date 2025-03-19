{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.bazarr = {
      enable = true;
      openFirewall = true;
      package = pkgs-unstable.bazarr;
    };
    services.caddy.virtualHosts."bazarr.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
      reverse_proxy http://127.0.0.1:6767
      '';
    };
    services.caddy.virtualHosts."bazarr.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
      reverse_proxy http://127.0.0.1:6767
      '';
    };
  };
}
