{ config, pkgs, ... }@inputs:
{
  longName = "Judah (P15)";

  programs.steam.enable = true;
  programs.captive-browser = {
    enable = true;
    interface = "wlp0s20f3";
  };

  hm.programs.niri.settings.outputs = {
    "eDP-1" = {
      position.x = 0;
      position.y = 0;
    };
    "DP-3" = {
      position.x = 1920;
      position.y = 0;
    };
  };

  hm.programs.noctalia-shell.settings = {
    bar.monitors = [ "eDP-1" ];
    notifications.monitors = [ "eDP-1" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  softColemak.enable = true;

  services.fprintd.enable = true;
}
