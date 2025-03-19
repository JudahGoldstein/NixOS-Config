{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/sonarr";
      package = pkgs-unstable.sonarr;
    };
    services.caddy.virtualHosts."sonarr.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8989
      '';
    };
  };
}
