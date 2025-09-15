{ config, pkgs, lib, ... }:
with lib.hm.gvariant;
{
  options = {
    gnome.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable GNOME desktop environment.";
    };
  };

  config = lib.mkIf config.gnome.enable {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
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
        };
        "org/gnome/mutter/keybindings" = {
          toggle-tiled-left = [ ];
          toggle-tiled-right = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" ];
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
        "org/gnome/nautilus/compression".default-compression-format = "7z";
      };
    };
  };
}
