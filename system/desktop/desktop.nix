{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./gnome.nix
      ./kde.nix
      ./openbox.nix
      ./xfce.nix
    ];

  services.xserver = {
    enable = true;
    excludePackages = [ ];
  };
}
