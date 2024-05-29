{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

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
