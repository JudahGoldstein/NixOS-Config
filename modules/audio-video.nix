{ config, pkgs, ... }@inputs:
{
  options = {
    easyeffects.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable easyeffects";
    };

    audacity.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable audacity";
    };

    vlc.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable VLC";
    };

    shotcut.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable shotcut";
    };

    ffmpeg.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable ffmpeg";
    };
  };

  config = {
    environment.systemPackages =
      with pkgs;
      inputs.lib.filter (pkg: pkg != null) [
        (if config.easyeffects.enable then easyeffects else null)
        (
          if config.easyeffects.enable then
            if config.gnome.enable then gnomeExtensions.easyeffects-preset-selector else null
          else
            null
        )
        (if config.audacity.enable then audacity else null)
        (if config.vlc.enable then vlc else null)
        (if config.shotcut.enable then shotcut else null)
        (if config.ffmpeg.enable then ffmpeg-full else null)
      ];
  };
}
