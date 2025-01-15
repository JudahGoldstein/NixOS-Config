{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    clamav.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Clam Antivirus";
    };
  };
  config = {
    services.clamav = mkIf config.clamav.enable {
      daemon.enable = true;
      fangfrisch.enable = true;
      updater.enable = true;
      scanner.enable = true;
      scanner.interval = "*-*-* 06:00:00";
      scanner.scanDirectories =
        [
          "/home"
          "/var/lib"
          "/tmp"
          "/etc"
          "/var/tmp"
          "/mnt/"
        ];
    };
  };
}
