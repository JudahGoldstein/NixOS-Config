{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  longName = "Judah (HS)";

  gnome.enable = true;
  media-server.enable = true;
  ollama.enable = true;
  sd-webui-forge.enable = false;
  audacity.enable = false;
  

  fileSystems."/mnt/media" =
    {
      device = "/dev/disk/by-uuid/2dfcbe87-8cbd-4363-bdb8-a4e24558e227";
      fsType = "ext4";
      options = [ "defaults" "nodiscard" ];
    };

  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
