{ config, pkgs, sops-nix, ... }:
{
  environment.systemPackages = with pkgs;[ sops ];
}
