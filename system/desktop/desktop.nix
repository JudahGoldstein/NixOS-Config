{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./gnome.nix
    ];

  services.xserver = {
    enable = true;
    excludePackages = [ ];
  };
}
