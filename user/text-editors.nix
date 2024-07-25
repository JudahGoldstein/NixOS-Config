{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    enableObsidian = mkOption {
      type = types.bool;
      default = true;
      description = "Enable obsidian";
    };

    enableLibreoffice = mkOption {
      type = types.bool;
      default = true;
      description = "Enable libreoffice suite";
    };
      qownnotes = mkOption {
      type = types.bool;
      default = false;
      description = "Enable qownnotes";
    };

  };

  config = {
    home.packages = with pkgs; lib.filter (pkg: pkg != null)
    [
      (if config.enableObsidian then pkgs.obsidian else null)
      (if config.enableLibreoffice then pkgs.libreoffice else null)
      (if config.qownnotes then pkgs.qownnotes else null)
    ];
  };
}

