{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./gnome.nix
      ./kde.nix
      ./openbox.nix
      ./xfce.nix
    ];

  gnome.enable = lib.mkDefault false;
  kde.enable = lib.mkDefault false;
  openbox.enable = lib.mkDefault false;
  xfce.enable = lib.mkDefault false;

  services.xserver = {
    enable = true;
    excludePackages = [ ];
  };
}
