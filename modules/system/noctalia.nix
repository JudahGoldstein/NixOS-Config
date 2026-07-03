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
      theme = {
        templates = {
          enable_builtin_templates = false;
          enable_community_templates = false;
        };
        source = "custom";
        custom_palette = "stylix";
      };
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
  hm.stylix.targets.noctalia-shell.enable = false;
  hm.xdg.configFile."noctalia/palettes/stylix.json".text =
    let
      colors = config.lib.stylix.colors.withHashtag;
    in
    builtins.toJSON {
      dark = {
        mPrimary = colors.base0D;
        mOnPrimary = colors.base00;
        mSecondary = colors.base0E;
        mOnSecondary = colors.base00;
        mTertiary = colors.base0C;
        mOnTertiary = colors.base00;
        mError = colors.base08;
        mOnError = colors.base00;
        mSurface = colors.base00;
        mOnSurface = colors.base05;
        mHover = colors.base0C;
        mOnHover = colors.base00;
        mSurfaceVariant = colors.base01;
        mOnSurfaceVariant = colors.base04;
        mOutline = colors.base03;
        mShadow = colors.base00;
        terminal = {
          foreground = colors.base07;
          background = colors.base00;
          normal = {
            black = colors.base00;
            red = colors.base08;
            green = colors.base0B;
            yellow = colors.base0A;
            blue = colors.base0D;
            magenta = colors.base0E;
            cyan = colors.base0C;
            white = colors.base07;
          };
          bright = {
            black = colors.base00;
            red = colors.base08;
            green = colors.base0B;
            yellow = colors.base0A;
            blue = colors.base0D;
            magenta = colors.base0E;
            cyan = colors.base0C;
            white = colors.base07;
          };
          cursor = colors.base07;
          cursorText = colors.base00;
          selectionFg = colors.base00;
          selectionBg = colors.base07;
        };
      };
    };
}
