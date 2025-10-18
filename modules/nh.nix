{ config, pkgs, ... }@inputs:
{
  programs.nh = {
    flake = "/etc/nixos";
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
  };
}
