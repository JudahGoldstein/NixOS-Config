{ config, pkgs, ... }@inputs:
{
  boot.loader.systemd-boot.netbootxyz.enable = true;
}
