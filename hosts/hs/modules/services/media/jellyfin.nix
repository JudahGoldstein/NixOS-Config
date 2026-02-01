{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../../../../../helpers/virtualHosts.nix inputs;
in
{
  config = {

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      cacheDir = "/var/cache/jellyfin";
      dataDir = "/var/lib/jellyfin";
      logDir = "/var/log/jellyfin";
      group = "media";
      package = pkgs.jellyfin;
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "jellyfin" 8096);
  };
}
