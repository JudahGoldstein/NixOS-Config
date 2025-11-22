{ config, pkgs, ... }@inputs:
{
  options = {
    obsidian.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable obsidian";
    };

    libreoffice.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable libreoffice suite";
    };

    micro.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
      description = "Enable micro";
    };
  };

  config = {
    environment.systemPackages =
      with pkgs;
      inputs.lib.filter (pkg: pkg != null) [
        (if config.obsidian.enable then obsidian else null)
        (if config.libreoffice.enable then libreoffice-fresh else null)
        (if config.micro.enable then micro else null)
        hunspell
        pdftk
      ];
  };
}
