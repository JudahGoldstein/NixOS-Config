{ config, pkgs, ... }@inputs:
{
  options = {
    keyboard.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable DIY keyboard service.";
    };
  };
  config = inputs.lib.mkIf config.keyboard.enable {
    environment.systemPackages = with pkgs; [
      via
      vial
    ];

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
