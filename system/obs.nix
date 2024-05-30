{ config, pkgs, lib, ... }:
{
  options = {
    obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the OBS Studio streaming software kernel module for virtual video devices.";
    };
  };

  config = {
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = [
      "v4l2loopback"
    ];
  };
}
