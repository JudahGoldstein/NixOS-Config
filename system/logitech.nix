{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    logitech.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable logitech wireless customization/support";
    };
  };

  config = lib.mkIf config.logitech.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
