{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = [ pkgs.base16-schemes ];
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/evenok-dark.yaml";
  stylix.polarity = "dark";
}
