{ config, pkgs, lib, ... }:
{
  options = {
    obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the OBS Studio streaming software kernel module for virtual video devices.";
    };
  };

  config = lib.mkIf config.obs.enable{
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = [
      "v4l2loopback"
    ];
  };
}
