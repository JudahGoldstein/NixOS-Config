{ config, pkgs, ... }@inputs:
{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = [ "gnome" ];
    };
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  hm.programs.niri = {
    settings = {
      input = {
        keyboard = {
          xkb.layout = "us, us(colemak)";
          xkb.options = "grp:win_space_toggle";
          numlock = true;
        };
        touchpad = {
          tap = true;
        };
        mouse = { };
        trackpoint = { };
      };
      layout = {
        gaps = 16;
        center-focused-column = "never";
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 0.5; }
          { proportion = 2.0 / 3.0; }
        ];
        default-column-width.proportion = 0.5;
        focus-ring.width = 4;
        border.enable = false;
        shadow.enable = false;
      };
      hotkey-overlay.skip-at-startup = false;
      spawn-at-startup = [
        { argv = [ "noctalia-shell" ]; } # }
      ];
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      animations.enable = true;
      window-rules = [
        {
          matches = [
            { app-id = "^org\\.wezfurlong\\.wezterm$"; }
          ];
          default-column-width = { };
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
      ];
      binds = {
        "Mod+Shift+Slash" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "plugin:keybind-cheatsheet"
            "toggle"
          ];
          hotkey-overlay.title = "Show all keybindings";
        };
        "Mod+Return" = {
          action.spawn = [ "kitty" ];
          hotkey-overlay.title = "Open a Terminal: kitty";
        };
        "Mod+D" = {
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
          hotkey-overlay.title = "Noctalia Launcher";
        };
        "XF86AudioRaiseVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn-sh = "playerctl play-pause";
          allow-when-locked = true;
        };
        "XF86AudioStop" = {
          action.spawn-sh = "playerctl stop";
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn-sh = "playerctl previous";
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn-sh = "playerctl next";
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "+10%"
          ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "set"
            "10%-"
          ];
          allow-when-locked = true;
        };
        "Mod+O" = {
          action.toggle-overview = [ ];
          repeat = false;
        };
        "Mod+Q" = {
          action.close-window = [ ];
          repeat = false;
        };
        "Mod+Left" = {
          action.focus-column-left = [ ];
        };
        "Mod+Down" = {
          action.focus-window-down = [ ];
        };
        "Mod+Up" = {
          action.focus-window-up = [ ];
        };
        "Mod+Right" = {
          action.focus-column-right = [ ];
        };
        "Mod+Shift+Left" = {
          action.move-column-left = [ ];
        };
        "Mod+Ctrl+Down" = {
          action.move-window-down = [ ];
        };
        "Mod+Shift+Up" = {
          action.move-window-up = [ ];
        };
        "Mod+Shift+Right" = {
          action.move-column-right = [ ];
        };
        "Mod+Ctrl+Left" = {
          action.focus-monitor-left = [ ];
        };
        "Mod+Shift+Down" = {
          action.focus-monitor-down = [ ];
        };
        "Mod+Ctrl+Up" = {
          action.focus-monitor-up = [ ];
        };
        "Mod+Ctrl+Right" = {
          action.focus-monitor-right = [ ];
        };
        "Mod+Shift+Ctrl+Left" = {
          action.move-column-to-monitor-left = [ ];
        };
        "Mod+Shift+Ctrl+Down" = {
          action.move-column-to-monitor-down = [ ];
        };
        "Mod+Shift+Ctrl+Up" = {
          action.move-column-to-monitor-up = [ ];
        };
        "Mod+Shift+Ctrl+Right" = {
          action.move-column-to-monitor-right = [ ];
        };
        "Mod+Page_Down" = {
          action.focus-workspace-down = [ ];
        };
        "Mod+Page_Up" = {
          action.focus-workspace-up = [ ];
        };
        "Mod+U" = {
          action.focus-workspace-down = [ ];
        };
        "Mod+I" = {
          action.focus-workspace-up = [ ];
        };
        "Mod+Ctrl+Page_Down" = {
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+Ctrl+Page_Up" = {
          action.move-column-to-workspace-up = [ ];
        };
        "Mod+Ctrl+U" = {
          action.move-column-to-workspace-down = [ ];
        };
        "Mod+Ctrl+I" = {
          action.move-column-to-workspace-up = [ ];
        };
        "Mod+Shift+Page_Down" = {
          action.move-workspace-down = [ ];
        };
        "Mod+Shift+Page_Up" = {
          action.move-workspace-up = [ ];
        };
        "Mod+Shift+U" = {
          action.move-workspace-down = [ ];
        };
        "Mod+Shift+I" = {
          action.move-workspace-up = [ ];
        };
        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [ ];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = [ ];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = [ ];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollRight" = {
          action.focus-column-right = [ ];
        };
        "Mod+WheelScrollLeft" = {
          action.focus-column-left = [ ];
        };
        "Mod+Ctrl+WheelScrollRight" = {
          action.move-column-right = [ ];
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          action.move-column-left = [ ];
        };
        "Mod+Shift+WheelScrollDown" = {
          action.focus-column-right = [ ];
        };
        "Mod+Shift+WheelScrollUp" = {
          action.focus-column-left = [ ];
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          action.move-column-right = [ ];
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          action.move-column-left = [ ];
        };
        "Mod+1" = {
          action.focus-workspace = 1;
        };
        "Mod+2" = {
          action.focus-workspace = 2;
        };
        "Mod+3" = {
          action.focus-workspace = 3;
        };
        "Mod+4" = {
          action.focus-workspace = 4;
        };
        "Mod+5" = {
          action.focus-workspace = 5;
        };
        "Mod+6" = {
          action.focus-workspace = 6;
        };
        "Mod+7" = {
          action.focus-workspace = 7;
        };
        "Mod+8" = {
          action.focus-workspace = 8;
        };
        "Mod+9" = {
          action.focus-workspace = 9;
        };
        "Mod+Shift+1" = {
          action.move-column-to-workspace = 1;
        };
        "Mod+Shift+2" = {
          action.move-column-to-workspace = 2;
        };
        "Mod+Shift+3" = {
          action.move-column-to-workspace = 3;
        };
        "Mod+Shift+4" = {
          action.move-column-to-workspace = 4;
        };
        "Mod+Shift+5" = {
          action.move-column-to-workspace = 5;
        };
        "Mod+Shift+6" = {
          action.move-column-to-workspace = 6;
        };
        "Mod+Shift+7" = {
          action.move-column-to-workspace = 7;
        };
        "Mod+Shift+8" = {
          action.move-column-to-workspace = 8;
        };
        "Mod+Shift+9" = {
          action.move-column-to-workspace = 9;
        };
        "Mod+BracketLeft" = {
          action.consume-or-expel-window-left = [ ];
        };
        "Mod+BracketRight" = {
          action.consume-or-expel-window-right = [ ];
        };
        "Mod+Comma" = {
          action.consume-window-into-column = [ ];
        };
        "Mod+Period" = {
          action.expel-window-from-column = [ ];
        };
        "Mod+R" = {
          action.switch-preset-column-width = [ ];
        };
        "Mod+Shift+R" = {
          action.switch-preset-window-height = [ ];
        };
        "Mod+Ctrl+R" = {
          action.reset-window-height = [ ];
        };
        "Mod+F" = {
          action.maximize-column = [ ];
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = [ ];
        };
        "Mod+Ctrl+F" = {
          action.expand-column-to-available-width = [ ];
        };
        "Mod+C" = {
          action.center-column = [ ];
        };
        "Mod+Ctrl+C" = {
          action.center-visible-columns = [ ];
        };
        "Mod+Minus" = {
          action.set-column-width = "-10%";
        };
        "Mod+Equal" = {
          action.set-column-width = "+10%";
        };
        "Mod+Shift+Minus" = {
          action.set-window-height = "-10%";
        };
        "Mod+Shift+Equal" = {
          action.set-window-height = "+10%";
        };
        "Mod+V" = {
          action.toggle-window-floating = [ ];
        };
        "Mod+Shift+V" = {
          action.switch-focus-between-floating-and-tiling = [ ];
        };
        "Mod+W" = {
          action.toggle-column-tabbed-display = [ ];
        };
        "Print" = {
          action.screenshot = [ ];
        };
        "Ctrl+Print" = {
          action.screenshot-screen = [ ];
        };
        "Alt+Print" = {
          action.screenshot-window = [ ];
        };
        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = [ ];
          allow-inhibiting = false;
        };
        "Mod+Shift+E" = {
          action.quit = [ ];
        };
        "Ctrl+Alt+Delete" = {
          action.quit = [ ];
        };
        "Mod+Shift+P" = {
          action.power-off-monitors = [ ];
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard-rs
  ];
  hm.programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        keybind-cheatsheet = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        niri-overview-launcher = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };
    settings = {
      appLauncher = {
        enableClipboardHistory = true;
        autoPasteClipboard = true;
        enableClipPreview = true;
        clipboardWrapText = true;
        clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
        clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
        position = "center";
        pinnedApps = [ ];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "kitty -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "list";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = false;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
        overviewLayer = false;
        density = "default";
      };
    };
  };
}
