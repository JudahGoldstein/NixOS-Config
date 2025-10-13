{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
{
  config = lib.mkIf config.media-server.enable {

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
