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
  };

  config = {
    home.packages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.easyeffects.enable then pkgs.easyeffects else null)
        (if config.gimp.enable then pkgs.gimp else null)
        (if config.audacity.enable then pkgs.audacity else null)
        (if config.vlc.enable then pkgs.vlc else null)

      ];
  };
}
