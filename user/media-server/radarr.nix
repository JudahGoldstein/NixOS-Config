{ config, pkgs, lib, ... }:
with lib;
{
  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr";
  };
}