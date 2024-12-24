{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    kitty.enable = mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkHard";
    };
  };
}
