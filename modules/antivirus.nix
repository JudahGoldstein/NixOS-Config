{ config, pkgs, ... }@inputs:
{
  services.clamav = {
    daemon.enable = inputs.lib.mkDefault false;
    fangfrisch.enable = config.services.clamav.daemon.enable;
    updater.enable = config.services.clamav.daemon.enable;
    scanner.enable = config.services.clamav.daemon.enable;
    scanner.interval = "*-*-* 06:00:00";
    scanner.scanDirectories = [
      "/home"
      "/var/lib"
      "/tmp"
      "/etc"
      "/var/tmp"
      "/mnt/"
    ];
  };
}
