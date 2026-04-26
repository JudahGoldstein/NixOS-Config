{ config, pkgs, ... }@inputs:
{
  options = {
    name = inputs.lib.mkOption {
      type = inputs.lib.types.str;
      description = "The hostname for this configuration";
    };
  };

  config = {
    services.fstrim.enable = true;
    services.fwupd.enable = true;
    environment.systemPackages = with pkgs; [
      nixos-facter
      ddcutil
      ddcutil-service
    ];
    hardware.i2c.enable = true;
    security.sudo-rs.enable = true;

    hm = {
      programs.home-manager.enable = true;
      home.username = config.name;
      home.homeDirectory = "/home/${config.name}";
      home.file = { };
      home.stateVersion = "23.11";
      home.sessionVariables = {
        EDITOR = "micro";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        TERM = "kitty";
      };
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "udev.log_level=3"
    ];
    boot.consoleLogLevel = 3;
    system.stateVersion = "23.11";
  };
}
