{ config, pkgs, ... }@inputs:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  longName = "Judah (v14)";

  softColemak.enable = true;
}
