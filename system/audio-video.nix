{ config, pkgs, lib, ... }:
{
  options = {
    easyeffects.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable easyeffects";
    };

    audacity.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable audacity";
    };

    vlc.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable VLC";
    };

    shotcut.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shotcut";
    };

    ffmpeg.enable = lib.mkOption {
      type = lib.types.bool;
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
