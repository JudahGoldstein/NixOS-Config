{ config, pkgs, ... }@inputs:
{
  options = {
    kitty.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = true;
    };
  };
  config = inputs.lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkHard";
    };
  };
}
