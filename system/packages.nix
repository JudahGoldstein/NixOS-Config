{ config, pkgs, lib, ... }:
with lib;
{
  nixpkgs.config.allowUnfree = true;
  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs;
    [
      # Downloaders
      wget
      curl
      git
      p7zip

      # Misc I always want
      fastfetch
      numlockx
      phoronix-test-suite

      # Communication
      zoom-us
      (pkgs.discord.override {
        # withOpenASAR = true; #causes error un updates
        withVencord = true;
      })

      # Security
      bitwarden-desktop

      # Misc
      # nerdfonts
      remmina

      # chrome for testing
      chromium
    ];
}
