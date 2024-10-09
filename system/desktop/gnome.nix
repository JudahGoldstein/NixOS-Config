{ config, pkgs, lib, pkgs-unstable, ... }:
{
  options = {
    gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME desktop environment.";
    };
  };

  config = lib.mkIf (config.gnome.enable == true) {
    environment.systemPackages = with pkgs; [ numlockx ];
    services.xserver = {
      displayManager = {
        setupCommands = ''
          ${pkgs.numlockx}/bin/numlockx on
        '';
        gdm = {
          enable = true;
          wayland = false;
        };
      };
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs;
      [
        gnome.eog
        gnome.epiphany
        gedit
        gnome.simple-scan
        gnome.totem
        gnome.yelp
        gnome.evince
        gnome.file-roller
        gnome.geary
        gnome.seahorse
        gnome.gnome-calculator
        gnome.gnome-clocks
        gnome.gnome-contacts
        gnome.gnome-font-viewer
        gnome.gnome-logs
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome-tour
      ];
  };
}
