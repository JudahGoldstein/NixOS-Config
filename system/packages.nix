{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs;
    [
      #editor
      micro

      #downloaders
      wget
      curl
      git

      #misc I always want
      neofetch
    ];
}
