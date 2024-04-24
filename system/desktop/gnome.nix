{ config, pkgs, lib, ... }:
{
    options = {
        gnome.enable = lib.mkEnableOption "gnome";
    };
    config = lib.mkIf config.gnome.enable{
        services.xserver.displayManager.gdm.enable = true;
        services.xserver.desktopManager.gnome.enable = true;
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
        gnome-console
        gnome-tour
        ];
    };
}
