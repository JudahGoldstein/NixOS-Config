{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../helpers/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      cacheDir = "/var/cache/jellyfin";
      dataDir = "/var/lib/jellyfin";
      logDir = "/var/log/jellyfin";
      package = pkgs.jellyfin;
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "jellyfin" 8096);
  };
}
