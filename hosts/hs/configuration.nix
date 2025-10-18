{ config, pkgs, ... }@inputs:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
      ./disks.nix
    ];

  longName = "Judah (HS)";

  media-server.enable = true;
  ollama.enable = true;
  sd-webui-forge.enable = false;
  audacity.enable = false;

  power.ups = {
    enable = true;
    mode = "standalone";
    ups."cyberpower-avr-1000" = {
      driver = "usbhid-ups";
      port = "auto";
    };
    users.nutmon = {
      passwordFile = config.sops.secrets."nutmon-password".path;
      upsmon = "primary";
    };
    upsmon = {
      user = "nutmon";
      monitor = {
        "cyberpower-avr-1000" = {
          user = config.power.ups.upsmon.user;
        };
      };
    };
  };

  fileSystems."/mnt/media" =
    {
      device = "/dev/disk/by-uuid/2dfcbe87-8cbd-4363-bdb8-a4e24558e227";
      fsType = "ext4";
      options = [ "defaults" "nodiscard" ];
    };

  boot.kernelPackages = pkgs.linuxPackages_cachyos-server;

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
