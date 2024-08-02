{ config, pkgs, ... }:
{
  imports =
    [
      ./system/networking.nix
      ./system/localization.nix
      ./system/io.nix
      ./system/sh.nix
      ./system/packages.nix
      ./system/desktop/desktop.nix
      ./system/battery.nix
      ./system/obs.nix
      ./system/nh.nix
      ./system/logitech.nix
      ./system/keyboard.nix
    ];
}
