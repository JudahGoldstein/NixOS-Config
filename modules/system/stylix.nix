{ config, pkgs, ... }@inputs:
{
  environment = inputs.lib.mkIf config.stylix.enable { systemPackages = [ pkgs.base16-schemes ]; };
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";
    cursor = {
      name = "Material";
      size = 24;
      package = pkgs.material-cursors;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    polarity = "dark";
  };
  hm.xdg.configFile.kdeglobals.source =
    let
      themePackage = builtins.head (
        builtins.filter (
          p: builtins.match ".*stylix-kde-theme.*" (baseNameOf p) != null
        ) config.hm.home.packages
      );
      colorSchemeSlug = inputs.lib.concatStrings (
        inputs.lib.filter inputs.lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
      );
    in
    "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";
}
