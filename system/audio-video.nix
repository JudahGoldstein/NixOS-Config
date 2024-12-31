{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    easyeffects.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable easyeffects";
    };

    gimp.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable gimp";
    };

    audacity.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable audacity";
    };

    vlc.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable VLC";
    };

    shotcut.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable shotcut";
    };

  };

  config = {
    environment.systemPackages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.easyeffects.enable then easyeffects else null)
        (if config.gimp.enable then gimp else null)
        (if config.audacity.enable then audacity else null)
        (if config.vlc.enable then vlc else null)
        (if config.shotcut.enable then shotcut else null)
      ];
  };
}
