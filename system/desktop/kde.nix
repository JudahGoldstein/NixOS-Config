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
    environment.systemPackages = with pkgs; [
      numlockx
      kdePackages.ksshaskpass
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
