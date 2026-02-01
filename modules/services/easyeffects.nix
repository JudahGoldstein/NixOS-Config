{ config, pkgs, ... }@inputs:
{
  hm.services.easyeffects = {
    enable = true;
    package = pkgs.easyeffects;
  };
}
