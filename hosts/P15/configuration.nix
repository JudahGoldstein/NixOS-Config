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
  };

  programs.nh.flake = /home/p15/NixOS-Config;
  
  # Enable automatic login for the user.
  services.displayManager.autoLogin = {
    enable = false;
    user = "p15";
  };

  networking.hostName = "p15";

  #SSD trimming
  services.fstrim.enable = true;

  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime.sync.enable = true;
  hardware.nvidia.prime = {
    nvidiaBusId = "PCI:01:00:0";  # Found with lspci | grep VGA
    intelBusId = "PCI:00:02:0";  # Found with lspci | grep VGA
  };

  gnome.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
