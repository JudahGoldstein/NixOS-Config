{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  name = "p15";
  longName = "Judah (P15)";

  networking.hostName = "v14";

  #SSD trimming
  services.fstrim.enable = true;

  gnome.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}