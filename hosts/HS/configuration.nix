{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  name = "p15";
  longName = "Judah (P15)";

  gnome.enable = true;

  networking.hostName = "HS";

  # SSD trimming
  services.fstrim.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
