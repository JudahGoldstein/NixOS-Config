{ config, pkgs, lib, ... }:
with lib;
{
  imports = 
  [
    ./sonarr.nix
    ./radarr.nix
    ./prowlarr.nix
    ./jellyfin.nix
  ];
}