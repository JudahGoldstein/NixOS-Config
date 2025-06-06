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
    environment.systemPackages = with pkgs; [
      numlockx
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.gsconnect
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.pip-on-top
    ];
    services.libinput.enable = true;
    services.displayManager = {
      enable = true;
      ly.enable = true;
      preStart = "";
    };
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs;
      [
        eog
        epiphany
        gedit
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
        gnome-tour
      ];
  };
}
