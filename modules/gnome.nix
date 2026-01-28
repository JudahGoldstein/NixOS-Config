{ config, pkgs, ... }@inputs:
{
  options = {
    gnome.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable GNOME desktop environment.";
    };
  };

  config = inputs.lib.mkIf config.gnome.enable {
    environment.systemPackages =
      (with pkgs.gnomeExtensions; [
        appindicator
        caffeine
        pip-on-top
        blur-my-shell
        clipboard-indicator
        bing-wallpaper-changer
        hide-top-bar
        gsconnect
        top-bar-organizer
        resource-monitor
      ])
      ++ (with pkgs; [
        gnome-tweaks
        gnome-extension-manager
      ]);
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
        x11Support = false;
      };
      generic.preStart = "";
    };
    services.desktopManager.gnome.enable = true;
    programs.evince.enable = true;
    environment.gnome.excludePackages = with pkgs; [
      eog
      epiphany
      gedit
      simple-scan
      totem
      yelp
      papers
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
    hm.dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          clock-show-seconds = true;
          clock-show-weekday = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/peripherals/keyboard".numlock-state = true;
        "org/gnome/desktop/privacy".report-technical-problems = false;
        "org/gnome/desktop/wm/keybindings" = {
          move-to-monitor-down = [ ];
          move-to-monitor-left = [ ];
          move-to-monitor-right = [ ];
          move-to-monitor-up = [ ];
          move-to-workspace-left = [ "<Shift><Super>Left" ];
          move-to-workspace-right = [ "<Shift><Super>Right" ];
          switch-to-workspace-left = [ "<Super>Left" ];
          switch-to-workspace-right = [ "<Super>Right" ];
          close = [ "<Alt>q" ];
          maximize = [ "<Super>Up" ];
        };

        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ ];
          toggle-tiled-right = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "kitty";
          name = "terminal";
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          edge-tiling = true;
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          natural-scroll = false;
          two-finger-scrolling-enabled = true;
        };
        "org/gtk/gtk4/settings/file-chooser".show-hidden = true;
        "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close";
      };
    };
  };
}
