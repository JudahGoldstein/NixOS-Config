{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    # services.sonarr = {
    #   enable = true;
    #   openFirewall = true;
    #   dataDir = "/var/lib/sonarr";
    #   package = pkgs.sonarr;
    # };
    # services.caddy.virtualHosts."sonarr.janjuta.duckdns.org" = {
    #   useACMEHost = "janjuta.duckdns.org";
    #   extraConfig = ''
    #     reverse_proxy http://127.0.0.1:8989
    #   '';
    # };
  };
}
