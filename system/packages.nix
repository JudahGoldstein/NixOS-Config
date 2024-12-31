{ config, pkgs, lib, ... }:
with lib;
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  # TODO make a VirtualBox module
  #virtualisation.virtualbox.host.enable = true;

  environment.systemPackages = with pkgs;
    [
      # Downloaders
      wget
      curl
      git

      # Misc I always want
      nerdfetch
      numlockx

      # Communication
      zoom-us
      (pkgs.discord.override {
        # withOpenASAR = true; #causes error un updates
        withVencord = true;
      })

      # Security
      bitwarden-desktop

      # Misc
      nerdfonts
      remmina

      # chrome for testing
      chromium
    ];
}
