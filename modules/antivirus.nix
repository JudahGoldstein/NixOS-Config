{ config, pkgs, ... }@inputs:
{
  options = {
    clamav.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable Clam Antivirus";
    };
  };
  config = {
    services.clamav = inputs.lib.mkIf config.clamav.enable {
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
