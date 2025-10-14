{ config, pkgs, ... }@inputs:
{
  options = {
    gnome.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable GNOME desktop environment.";
    };

  };
  config = inputs.lib.mkIf (config.gnome.enable == true) {
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.pip-on-top
      gnomeExtensions.tiling-shell
    ];
    services.libinput.enable = true;
    services.displayManager = {
      enable = true;
      ly = {
        enable = true;
        settings = {
          allow_empty_password = false;
          clear_password = true;
          hide_version_string = true;
          numlock = true;
        };
      };
      preStart = "";
    };
    services.desktopManager.gnome.enable = true;
    programs.evince.enable = true;
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
