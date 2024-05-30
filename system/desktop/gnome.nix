{ config, pkgs, lib, ... }:
{
  options = {
    gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME desktop environment.";
    };
  };

  config = lib.mkIf (config.gnome.enable == true) {
    services.xserver = {
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
      desktopManager.gnome.enable = true;
    };
    environment.gnome.excludePackages = with pkgs.gnome;
      [
        eog
        epiphany
        pkgs.gedit
        simple-scan
        totem
        yelp
        evince
        file-roller
        geary
        seahorse
        gnome-calculator
        gnome-clocks
        gnome-contacts
        gnome-font-viewer
        gnome-logs
        gnome-maps
        gnome-music
        gnome-weather
        pkgs.gnome-connections
        gnome-terminal
        pkgs.gnome-console
        pkgs.gnome-tour
      ];
  };
}
