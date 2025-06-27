{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  name = "v14";
  longName = "Judah (v14)";

  networking.hostName = "v14";

  blocky.enable = true;
  tailscale.enable = true;

  #SSD trimming
  services.fstrim.enable = true;

  gnome.enable = true;

  softColemak.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
