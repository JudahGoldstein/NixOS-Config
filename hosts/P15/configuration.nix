{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  users.users.p15 = {
    isNormalUser = true;
    description = "Judah (P15)";
    extraGroups = [ "networkmanager" "wheel" "dialout" "uucp" ];
    packages = with pkgs; [ ];
    hashedPassword = "$y$j9T$iI82A2cddkXao1pEJQOp30$qU46CY2F/iJRwjgi2I4oH4sSwJHUxKBG2nnh.fIUZ95";
  };

  programs.nh.flake = /home/p15/NixOS-Config;

  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "p15";
  };

  networking.hostName = "p15";

  # SSD trimming
  services.fstrim.enable = true;

  fileSystems."/bulk" =
    {
      device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
      fsType = "ext4";
    };


  # Prime for Nvidia Optimus
  nvidia-prime.enable = true;
  nvidia-prime.offload = true;

  gnome.enable = true;

  steam.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
