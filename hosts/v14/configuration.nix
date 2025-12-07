{ config, pkgs, ... }@inputs:
{
  longName = "Judah (v14)";

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  softColemak.enable = true;
}
