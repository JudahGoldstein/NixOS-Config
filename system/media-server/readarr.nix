{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.readarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/readarr";
      package = pkgs-unstable.readarr;
    };
    services.caddy.virtualHosts."readarr.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8787
      '';
    };
    services.caddy.virtualHosts."readarr.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8787
      '';
    };
  };
}
