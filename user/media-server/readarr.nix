{ config, pkgs, lib, ... }:
with lib;
{
  services.readarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/readarr";
  };
}