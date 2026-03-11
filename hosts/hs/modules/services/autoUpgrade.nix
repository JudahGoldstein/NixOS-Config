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
}
