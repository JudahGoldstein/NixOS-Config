{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    obsidian.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable obsidian";
    };

    libreoffice.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable libreoffice suite";
    };
    qownnotes.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable qownnotes";
    };

  };

  config = {
    home.packages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.obsidian.enable then pkgs.obsidian else null)
        (if config.libreoffice.enable then pkgs.libreoffice else null)
        (if config.qownnotes.enable then pkgs.qownnotes else null)
        hunspell
      ];
  };
}

