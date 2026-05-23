{ config, pkgs, ... }@inputs:
{
  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
  hm.services.mpris-proxy.enable = true;
}
