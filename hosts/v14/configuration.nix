{ config, pkgs, ... }@inputs:
{
  longName = "Judah (v14)";

  programs.captive-browser = {
    enable = true;
    interface = "wlp2s0";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  softColemak.enable = true;
}
