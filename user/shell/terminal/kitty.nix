{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "GruvboxMaterialDarkHard";
  };
}
