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
    environment.plasma6.excludePackages = with pkgs.kdePackages;
      [
        konsole
        elisa
      ];
    environment.systemPackages = with pkgs.kdePackages;
      [
        ksshaskpass
      ];
    environment = {
      sessionVariables = {
        SSH_ASKPASS_REQUIRE = "prefer";
      };
    };
  };
}
