{ config, pkgs, lib, ... }:
{
  options = {
    kde.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Plasma Desktop Environment";
    };
  };
  config = lib.mkIf (config.kde.enable == true) {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    services.xserver.displayManager.defaultSession = "plasmax11";
    services.xserver.displayManager.sddm.wayland.enable = false;
    environment.plasma6.excludePackages = with pkgs.kdePackages;
      [
        konsole
        elisa
        kwalletmanager
      ];
  };
}
