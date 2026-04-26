{ config, pkgs, ... }@inputs:
{
  programs.nh = {
    enable = true;
    flake = "github:JudahGoldstein/NixOS-Config";
  };
}
