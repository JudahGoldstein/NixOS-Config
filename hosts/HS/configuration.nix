{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  users.users.hs = {
    isNormalUser = true;
    description = "Judah (HS)";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
    packages = with pkgs; [ ];
    hashedPassword = "$y$j9T$RPFzU86KqNqNoMSs3Ezv//$uZfY7uCkqkHdknuEGmR3wuovjd344jaGCfO2TMZ9LjB";
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "HS";
  };

  gnome.enable = true;
  
  networking.hostName = "HS";
  services.openssh.enable = true;

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
