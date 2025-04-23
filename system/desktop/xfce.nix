{ config, pkgs, lib, ... }:
{
  options = {
    xfce.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the XFCE desktop environment.";
    };
  };
  config = lib.mkIf (config.xfce.enable == true) {
    services.displayManager = {
      enable = true;
      ly.enable = true;
      preStart = "";
    };
    services.xserver.desktopManager.xfce.enable = true;
  };
}
