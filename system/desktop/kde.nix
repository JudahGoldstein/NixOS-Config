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
    services.xserver = {
      displayManager = {
        setupCommands = ''
          ${pkgs.numlockx}/bin/numlockx on
        '';
        gdm = {
          enable = true;
          wayland = true;
          autoSuspend = false;
        };
      };
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
