{ config, pkgs, ... }@inputs:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-prime.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  longName = "Judah (P15)";

  steam.enable = true;

  fileSystems."/bulk" =
    {
      device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
      fsType = "ext4";
    };

  # Prime for Nvidia Optimus
  nvidia-prime.enable = true;
  nvidia-prime.offload = true;

  softColemak.enable = true;

  services.fprintd.enable = true;
}
