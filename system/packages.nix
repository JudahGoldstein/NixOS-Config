{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs;
    [
      #editor
      micro

      #downloaders
      wget
      curl

      #misc I always want
      neofetch
    ];
}
