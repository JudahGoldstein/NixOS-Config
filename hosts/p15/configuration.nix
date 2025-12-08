{ config, pkgs, ... }@inputs:
{
  longName = "Judah (P15)";

  steam.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  softColemak.enable = true;

  services.fprintd.enable = true;
}
