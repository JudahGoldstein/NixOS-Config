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
    home-manager.users.judah = {
        dconf = {
            enable = true;
            settings= {
                "org/gnome/desktop/interface" = {
                    color-scheme = "prefer-dark";
                    gtk-theme = "Adwaita-dark";
                    clock-show-seconds = true;
                    clock-show-weekday = true;
                };
                "org/gnome/desktop/peripherals/keyboard".numlock-state = true;
                "org/gnome/desktop/privacy".report-technical-problems = false;
                "org/gnome/desktop/wm/keybindings"={
                    move-to-monitor-down = "@as []";
                    move-to-monitor-left = "@as []";
                    move-to-monitor-right = "@as []";
                    move-to-monitor-up = "@as []";
                    move-to-workspace-left = "['<Shift><Super>Left']";
                    move-to-workspace-right = "['<Shift><Super>Right']";
                    switch-to-workspace-left = "['<Super>Left']";
                    switch-to-workspace-right = "['<Super>Right']";
                };
                "org/gnome/mutter/keybindings" = {
                    toggle-tiled-left = "@as []";
                    toggle-tiled-right = "@as []";
                };
                "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
                "org/gnome/nautilus/compression".default-compression-format = "'7z'";

                "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                    binding = "<Super>Return";
                    command = gnome.terminal;
                    name = "terminal";
                };
            };
        };
    };
}
