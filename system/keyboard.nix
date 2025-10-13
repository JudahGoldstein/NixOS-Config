{ config, pkgs, lib, ... }:
{
  options = {
    keyboard.enable = lib.mkOption {
      default = false;
      description = "Enable DIY keyboard service.";
    };
  };
  config = lib.mkIf config.keyboard.enable {
    environment.systemPackages = with pkgs;
      [
        via
        vial
      ];

    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
