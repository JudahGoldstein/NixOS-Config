{ config, pkgs, lib, ... }:
with lib;
{
  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };
}