{ config, pkgs, ... }@inputs:
{
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
}
