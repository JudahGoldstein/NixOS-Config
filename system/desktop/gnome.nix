{ config, pkgs, lib, ... }:
{
    options = {
        gnome.enable = lib.mkEnableOption "gnome";
        gnome.terminal = lib.mkTextOption {
            default = "kitty";
            example = "gnome-terminal";
            description = "The terminal emulator to use.";
        };
    };
    config = lib.mkIf config.gnome.enable {
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
        pkgs.gnome-console
        pkgs.gnome-tour
        ];
    };
}
