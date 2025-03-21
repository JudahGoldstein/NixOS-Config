{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    keyboard.enable = mkOption {
      default = false;
      description = "Enable DIY keyboard service.";
    };
  };
  config = mkIf config.keyboard.enable {
    environment.systemPackages = with pkgs;
      [
        via
        vial
      ];

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
