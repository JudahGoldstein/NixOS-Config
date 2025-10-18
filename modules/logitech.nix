{ config, pkgs, ... }@inputs:
{
  options = {
    logitech.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable logitech wireless customization/support";
    };
  };

  config = inputs.lib.mkIf config.logitech.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
