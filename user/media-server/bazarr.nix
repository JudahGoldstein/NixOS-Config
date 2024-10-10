{ config, pkgs, lib, ... }:
with lib;
{
  services.bazarr = {
    enable = true;
    openFirewall = true;
  };
}