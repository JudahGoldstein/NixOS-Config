{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    easyeffects.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable easyeffects";
    };

    audacity.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable audacity";
    };

    vlc.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable VLC";
    };

    shotcut.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable shotcut";
    };

    ffmpeg.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable ffmpeg";
    };
  };

  config = {
    environment.systemPackages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.easyeffects.enable then easyeffects else null)
        (if config.audacity.enable then audacity else null)
        (if config.vlc.enable then vlc else null)
        (if config.shotcut.enable then shotcut else null)
        (if config.ffmpeg.enable then ffmpeg-full else null)
      ];
  };
}
