{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  name = "hs";
  longName = "Judah (HS)";

  blocky.enable = true;
  gnome.enable = true;
  media-server.enable = true;
  wireguard.enable = true;
  ollama.enable = true;
  forge.enable = true;

  fileSystems."/mnt/media" =
    {
      device = "/dev/disk/by-uuid/2dfcbe87-8cbd-4363-bdb8-a4e24558e227";
      fsType = "ext4";
      options = [ "defaults" "nodiscard" ];
    };

  # SSD trimming
  services.fstrim.enable = true;

  boot.kernelParams = [ "processor.max_cstate=5" ];

  # Nvida drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
