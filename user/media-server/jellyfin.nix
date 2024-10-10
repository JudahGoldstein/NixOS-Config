{ config, pkgs, lib, ... }:
with lib;
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    mediaDir = "/mnt/media";
    cacheDir = "/var/cache/jellyfin";
    dataDir = "/var/lib/jellyfin";
    logDir = "/var/log/jellyfin";
  };
}
