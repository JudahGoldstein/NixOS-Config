{ config, pkgs, ... }@inputs:
{

  environment.systemPackages = with pkgs; [
    # Downloaders
    wget
    curl
    p7zip

    # Misc I always want
    fastfetch
    numlockx
    phoronix-test-suite

    # Communication
    packet
    thunderbird

    # Security
    bitwarden-desktop

    # Misc
    remmina

    # chrome for testing
    chromium
  ];
}
