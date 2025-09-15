{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  longName = "Judah (v14)";

  networking.hostName = "v14";

  gnome.enable = true;
  softColemak.enable = true;
}
