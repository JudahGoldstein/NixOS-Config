{ config, pkgs, ... }@inputs:
{
  services.udisks2.enable = true;
  hm.services.udiskie = {
    enable = true;
    tray = "never";
  };
}
