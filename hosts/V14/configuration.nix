{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  users.users.v14 = {
    isNormalUser = true;
    description = "Judah (V14)";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
    packages = with pkgs; [ ];
  };

  programs.nh.flake=/home/v14/NixOS-Config;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "v14";
  };

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
