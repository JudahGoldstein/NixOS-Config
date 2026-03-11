{ config, pkgs, ... }@inputs:
{
  system.autoUpgrade = {
    enable = true;
    flake = "github:JudahGoldstein/NixOS-Config";
    dates = "08:00 UTC";
    upgrade = false;
    allowReboot = true;
    flags = [
      "--print-build-logs"
      "--accept-flake-config"
    ];
  };
  programs.nh.clean = {
    enable = true;
    dates = "09:00 UTC";
    extraArgs = "--keep 3";
  };
}
