{ config, pkgs, lib, ... }:
{
  options = {
    openbox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Openbox window manager";
    };
  };
  config = lib.mkIf (config.openbox.enable == true) {
    services.displayManager = {
      enable = true;
      ly.enable = true;
      preStart = "";
    };
    services.xserver.windowManager.openbox.enable = true;
  };
}
