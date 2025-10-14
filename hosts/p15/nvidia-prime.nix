{ config, pkgs, ... }@inputs:
{
  options = {
    nvidia-prime.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable nvidia";
    };
    nvidia-prime.sync = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable nvidia sync mode";
    };
    nvidia-prime.offload = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable nvidia offload mode";
    };
  };
  config = inputs.lib.mkIf config.nvidia-prime.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      prime = {
        sync = inputs.lib.mkIf config.nvidia-prime.sync {
          enable = true;
        };
        offload = inputs.lib.mkIf config.nvidia-prime.offload {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:01:00:0";
        intelBusId = "PCI:00:02:0";
      };
    };
  };
}
