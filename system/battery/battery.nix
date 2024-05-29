{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./power-profiles.nix
      ./tpl.nix
    ];

  tpl.enable = mkDefault true;
  power-profiles.enable = mkDefault false;
}
