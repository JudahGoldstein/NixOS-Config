{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    power-profiles.enable = mkEnableOption "enable power-profiles (gnome)";
  };
  config = mkIf config.power-profiles.enable {
    powerManagement.enable = true;
    services.power-profiles-daemon.enable = false;
  };
}
