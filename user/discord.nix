{ config, pkgs, lib, ... }:
with lib;
{
  programs.vesktop = {
    enable = true;
  };
}
