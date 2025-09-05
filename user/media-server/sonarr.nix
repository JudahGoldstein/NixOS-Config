{ config, pkgs, lib, ... }:
with lib;
{
  services.sonarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/sonarr";
  };
}