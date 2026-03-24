{ config, pkgs, ... }@inputs:
{
  programs.gnome-disks.enable = true;
  environment.systemPackages = [
    pkgs.gnome-disk-utility
  ];
}
