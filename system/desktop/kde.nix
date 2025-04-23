{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    kde.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable KDE Plasma Desktop Environment";
    };
  };
  config = mkIf config.kde.enable {
    environment.systemPackages = with pkgs; [
      numlockx
      kdePackages.ksshaskpass
      ocs-url
      ddcutil
    ];
    services.displayManager = {
      enable = true;
      ly.enable = true;
      preStart = "";
    };
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages;
      [
        konsole
        elisa
      ];
    environment = {
      sessionVariables = {
        SSH_ASKPASS_REQUIRE = "prefer";
      };
    };
  };
}
