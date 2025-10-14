{ config, pkgs, ... }@inputs:
{
  nixpkgs.config.allowUnfree = true;

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

      thunderbird

      # Security
      bitwarden-desktop

      # Misc
      remmina

      # chrome for testing
      chromium
    ];
}
