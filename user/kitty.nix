{ config, pkgs, lib, ... }:
{
  options = {
    kitty.enable = lib.mkOption {
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
