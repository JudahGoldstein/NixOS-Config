{ config, pkgs, ... }@inputs:
let
  officialPlugins = "https://github.com/noctalia-dev/noctalia-plugins";
  dailyWalls = "https://github.com/JudahGoldstein/daily-walls";
in
{
  environment.systemPackages = with pkgs; [
    wl-clipboard-rs
    cliphist
    gnome-system-monitor
  ];
  services.upower.enable = true;
  hm.programs.noctalia = {
    enable = true;
    settings = {
      backdrop.enabled = true;
      bar.default = {
        capsule = true;
        center = [
          "clock"
          "date"
        ];
        end = [
          "tray"
          "clipboard"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "notifications"
          "control-center"
        ];
        font_weight = 400;
        margin_edge = 0;
        margin_ends = 0;
        radius = 0;
        start = [
          "workspaces"
          "sysmon"
          "cpu"
          "ram"
        ];
        thickness = 30;
        widget_spacing = 10;
      };
      calendar = {
        enabled = true;
        account.personal_google.type = "google";
      };
      control_center = {
        sidebar = "full";
        shortcuts = [
          { type = "wifi"; }
          { type = "caffeine"; }
          { type = "notification"; }
        ];
      };
      desktop_widgets.enabled = false;
      location.auto_locate = true;
      lockscreen.enabled = false;
      lockscreen_widgets.enabled = false;
      shell = {
        niri_overview_type_to_launch_enabled = true;
        show_location = false;
        animation.enabled = false;
        panel = {
          clipboard_placement = "attached";
          open_near_click_clipboard = true;
          open_near_click_control_center = true;
          open_near_click_session = true;
          open_near_click_wallpaper = true;
        };
        screenshot.save_to_file = false;
        session.actions = [
          {
            action = "lock";
            countdown_seconds = 0.0;
            enabled = false;
            shortcut = "1";
            variant = "default";
          }
          {
            action = "logout";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "2";
            variant = "default";
          }
          {
            action = "lock_and_suspend";
            countdown_seconds = 0.0;
            enabled = false;
            shortcut = "3";
            variant = "default";
          }
          {
            action = "reboot";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "4";
            variant = "default";
          }
          {
            action = "shutdown";
            countdown_seconds = 0.0;
            enabled = true;
            shortcut = "5";
            variant = "destructive";
          }
        ];
      };
      theme.builtin = "Catppuccin"; # until i get stylix working
      wallpaper.enabled = false;
      widget = {
        battery.display_mode = "graphic";
        brightness.show_label = false;
        control-center.glyph = "north-star";
        cpu.display = "graph";
        date.format = "{:%A, %Y-%m-%d}";
        network.show_label = false;
        ram.display = "graph";
        sysmon = {
          display = "text";
          stat = "cpu_temp";
        };
      };
    };
  };
}
