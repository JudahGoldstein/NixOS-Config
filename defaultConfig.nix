{ config, pkgs, ... }:
{
  imports =
    [
      ./system/networking.nix
      ./system/localization.nix
      ./system/io.nix
      ./system/sh.nix
      ./system/packages.nix
      ./system/users.nix
      ./system/desktop/desktop.nix
      ./system/battery/battery.nix
      ./system/obs.nix
    ];
}
