{ config, pkgs, lib, ... }:
{
  options = {
    gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable GNOME desktop environment.";
    };
    gnome.remote = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable remote access feature for GNOME.";
    };
  };

  config = lib.mkIf (config.gnome.enable == true) {
    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.caffeine
      gnomeExtensions.pip-on-top
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
    programs.nautilus-open-any-terminal = lib.mkIf (config.kitty.enable == true) {
      enable = true;
      terminal = "kitty";
    };
    services.gnome.gnome-remote-desktop.enable = true;

    systemd.services.gnome-remote-desktop = {
      wantedBy = [ "graphical.target" ];
    };
    networking.firewall.allowedTCPPorts = [ 3389 ];
  };
}
