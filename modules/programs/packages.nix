{ config, pkgs, ... }@inputs:
{

  environment.systemPackages = with pkgs; [
    # Downloaders
    wget
    curl
    p7zip

    # Misc I always want
    fastfetch

    # Communication
    packet
    teams-for-linux

    # Security
    bitwarden-desktop

    # chrome for testing
    chromium
  ];
}
