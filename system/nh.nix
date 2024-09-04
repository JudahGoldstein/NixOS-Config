{ config, pkgs, ... }:
{
  programs.nh = {
    programs.nh.flake = /etc/nixos;
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
  };
}
