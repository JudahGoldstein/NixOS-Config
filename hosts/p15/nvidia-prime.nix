{ config, pkgs, lib, ... }:
{
  options = {
    nvidia-prime.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nvidia";
    };
    nvidia-prime.sync = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nvidia sync mode";
    };
    nvidia-prime.offload = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nvidia offload mode";
    };
  };
  config = lib.mkIf config.nvidia-prime.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      prime = {
        sync = lib.mkIf config.nvidia-prime.sync {
          enable = true;
        };
        offload = lib.mkIf config.nvidia-prime.offload {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:01:00:0";
        intelBusId = "PCI:00:02:0";
      };
    };
  };
}
