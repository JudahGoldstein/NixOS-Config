{ config, pkgs, ... }@inputs:
let
  officialPlugins = "https://github.com/noctalia-dev/noctalia-plugins";
  dailyWalls = "https://github.com/JudahGoldstein/daily-walls";
in
{
  environment.systemPackages = with pkgs; [
    wl-clipboard-rs
    cliphist
  ];
  services.upower.enable = true;
  hm.programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = officialPlugins;
        }
        {
          enable = true;
          name = "Daily Walls";
          url = dailyWalls;
        }
      ];
      states =
        builtins.mapAttrs
          (name: value: if value ? sourceUrl then value else value // { sourceUrl = officialPlugins; })
          {
            keybind-cheatsheet = {
              enabled = true;
            };
            niri-overview-launcher = {
              enabled = true;
            };
            clipper = {
              enabled = true;
            };
            kde-connect = {
              enabled = true;
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
        showCategories = false;
        iconMode = "tabler";
        showIconBackground = false;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        enableSessionSearch = true;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
        overviewLayer = false;
        density = "default";
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 30;
        visualizerType = "linear";
        mprisBlacklist = [ ];
        preferredPlayer = "";
        volumeFeedback = false;
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      templates = {
        activeTemplates = [ ];
        enableUserTheming = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
        startup = "";
        session = "";
      };
      plugins = {
        autoUpdate = true;
      };
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [ ];
      };
      dock = {
        enabled = false;
      };
      bar = {
        barType = "simple";
        position = "top";
        monitors = [ ];
        density = "default";
        showOutline = false;
        showCapsule = true;
        capsuleColorKey = "none";
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        hideOnOverview = false;
        displayMode = "always_visible";
        autoHideDelay = 500;
        autoShowDelay = 150;
        widgets = {
          left = [
            {
              id = "Launcher";
              icon = "rocket";
              iconColor = "none";
            }
            {
              id = "Clock";
              clockColor = "none";
              customFont = "";
              useCustomFont = false;
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              tooltipFormat = "HH:mm ddd, MMM dd";
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
              showCpuFreq = false;
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = false;
              showSwapUsage = false;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = true;
            }
            {
              id = "ActiveWindow";
              colorizeIcons = false;
              hideMode = "hidden";
              maxWidth = 145;
              scrollingMode = "hover";
              showIcon = true;
              textColor = "none";
              useFixedWidth = false;
            }
            {
              id = "MediaMini";
              compactMode = false;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              maxWidth = 145;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          center = [
            {
              id = "Workspace";
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              labelMode = "index";
              occupiedColor = "secondary";
              pillSize = 0.6;
              reverseScroll = false;
              showApplications = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
          ];
          right = [
            {
              id = "Tray";
              blacklist = [ ];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = false;
              pinned = [ ];
            }
            {
              id = "plugin:clipper";
              defaultSettings = {
                enableTodoIntegration = false;
                noteCardsEnabled = true;
                pincardsEnabled = true;
                position = "Top";
                showCloseButton = true;
                reverseScroll = false;
              };
            }
            {
              id = "plugin:kde-connect";
              docker-containers = { };
            }
            {
              id = "NotificationHistory";
              hideWhenZero = true;
              hideWhenZeroUnread = false;
              iconColor = "none";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
            {
              id = "Battery";
              deviceNativePath = "__default__";
              displayMode = "graphic-clean";
              hideIfIdle = false;
              hideIfNotDetected = true;
              showNoctaliaPerformance = false;
              showPowerProfiles = true;
            }
            {
              id = "Volume";
              displayMode = "onhover";
              iconColor = "none";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              id = "Brightness";
              displayMode = "onhover";
              iconColor = "none";
              textColor = "none";
              applyToAllMonitors = true;
            }
            {
              id = "ControlCenter";
              colorizeDistroLogo = false;
              colorizeSystemIcon = false;
              enableColorization = false;
              customIconPath = "";
              icon = "noctalia";
              useDistroLogo = true;
            }
          ];
        };
        screenOverrides = [ ];
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
          ];
          right = [
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = false;
            id = "media-sysmon-card";
          }
        ];
      };
      network = {
        airplaneModeEnabled = false;
        wifiEnabled = true;
        wifiDetailsViewMode = "grid";
        bluetoothRssiPollingEnabled = true;
        bluetoothRssiPollIntervalMs = 60000;
        disableDiscoverability = true;
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = true;
      };
      notifications = {
        enabled = true;
        enableMarkdown = true;
        density = "default";
        monitors = [ ];
        location = "top_right";
        overlayLayer = true;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        clearDismissed = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
        };
        enableMediaToast = false;
        enableKeyboardLayoutToast = true;
        enableBatteryToast = true;
      };
      osd = {
        enabled = true;
        location = "top_right";
        autoHideMs = 2000;
        overlayLayer = true;
        enabledTypes = [
          0
          1
          2
        ];
        monitors = [ ];
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = true;
        largeButtonsLayout = "single-row";
        powerOptions = [
          {
            action = "lock";
            enabled = false;
          }
          {
            action = "suspend";
            enabled = false;
          }
          {
            action = "hibernate";
            enabled = false;
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "1";
          }
          {
            action = "logout";
            enabled = true;
            keybind = "2";
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "3";
          }
        ];
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 90;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        swapWarningThreshold = 80;
        swapCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        diskAvailWarningThreshold = 20;
        diskAvailCriticalThreshold = 10;
        batteryWarningThreshold = 20;
        batteryCriticalThreshold = 5;
        enableDgpuMonitoring = false;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      general = {
        avatarImage = "";
        dimmerOpacity = 0.2;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1;
        radiusRatio = 1;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockScreenAnimations = false;
        lockOnSuspend = true;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        language = "";
        allowPanelsOnScreenWithoutBar = true;
        showChangelogOnStartup = true;
        telemetryEnabled = false;
        enableLockScreenCountdown = true;
        lockScreenCountdownDuration = 10000;
        autoStartAuth = false;
        allowPasswordWithFprintd = false;
        clockStyle = "custom";
        clockFormat = "hh\nmm";
        lockScreenMonitors = [ ];
        lockScreenBlur = 0;
        lockScreenTint = 0;
        reverseScroll = false;
        keybinds = {
          keyUp = [ "Up" ];
          keyDown = [ "Down" ];
          keyLeft = [ "Left" ];
          keyRight = [ "Right" ];
          keyEnter = [ "Return" ];
          keyRemove = [ "Del" ];
          keyEscape = [ "Esc" ];
        };
      };
      ui = {
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };
      location = {
        weatherEnabled = false;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherTimezone = false;
        hideWeatherCityName = true;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };
      wallpaper = {
        enabled = false;
      };
    };
  };
}
