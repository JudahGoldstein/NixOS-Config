{ config, pkgs, lib, ... }:
{
  options = {
    obsidian.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable obsidian";
    };

    libreoffice.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable libreoffice suite";
    };

    qownnotes.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable qownnotes";
    };

    micro.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable micro";
    };
  };

  config = {
    environment.systemPackages = with pkgs; lib.filter (pkg: pkg != null)
      [
        (if config.obsidian.enable then obsidian else null)
        (if config.libreoffice.enable then libreoffice-fresh else null)
        (if config.qownnotes.enable then qownnotes else null)
        (if config.micro.enable then micro else null)
        hunspell
        pdftk
      ];
  };
}

