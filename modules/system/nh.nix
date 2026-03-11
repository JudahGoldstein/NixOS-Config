{ config, pkgs, ... }@inputs:
{
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };
}
