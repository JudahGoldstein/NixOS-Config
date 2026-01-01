{ config, pkgs, ... }@inputs:
{
  longName = "Judah (P15)";

  steam.enable = true;
  programs.captive-browser = {
    enable = true;
    interface = "wlp0s20f3";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  softColemak.enable = true;

  services.fprintd.enable = true;
}
