{ config, pkgs, ... }@inputs:
{
  longName = "Judah (P15)";

  steam.enable = true;

  fileSystems."/bulk" = {
    device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
    fsType = "ext4";
  };

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  softColemak.enable = true;

  services.fprintd.enable = true;
}
