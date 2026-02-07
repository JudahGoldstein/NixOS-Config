{ config, pkgs, ... }@inputs:
{
  environment = inputs.lib.mkIf config.stylix.enable { systemPackages = [ pkgs.base16-schemes ]; };
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/material-darker.yaml";
  stylix.polarity = "dark";
  stylix.targets.qt.platform = inputs.lib.mkForce "qtct";
  hm.qt.platformTheme = inputs.lib.mkIf config.stylix.enable { name = inputs.lib.mkForce "adwaita"; };
}
