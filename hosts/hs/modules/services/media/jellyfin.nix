{ config, pkgs, ... }@inputs:

{

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    cacheDir = "/var/cache/jellyfin";
    dataDir = "/var/lib/jellyfin";
    logDir = "/var/log/jellyfin";
    group = "media";
    package = pkgs.jellyfin;
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkPublicVirtualHost "jellyfin" 8096);
}
