{ config, pkgs, ... }@inputs:
{
  longName = "Judah (v14)";

  programs.captive-browser = {
    enable = true;
    interface = "wlp2s0";
  };
  hm.programs.niri.settings.outputs = {
    "eDP-1" = {
      position.x = 0;
      position.y = 0;
      scale = 1.0;
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  softColemak.enable = true;
}
