{ config, pkgs, ... }@inputs:
{
  system.autoUpgrade = {
    enable = true;
    flake = "github:JudahGoldstein/NixOS-Config";
    dates = "08:00 UTC";
    allowReboot = true;
    flags = [
      "--print-build-logs"
    ];
  };
}
