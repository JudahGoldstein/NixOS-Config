{ config, pkgs, ... }@inputs:
{
  config = {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      modesetting.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:01:00:0";
        intelBusId = "PCI:00:02:0";
      };
    };
    specialisation.gaming.configuration = {
      hardware.nvidia.prime = {
        offload = {
          enable = inputs.lib.mkForce false;
          enableOffloadCmd = inputs.lib.mkForce false;
        };
        sync.enable = inputs.lib.mkForce true;
      };
    };
  };
}
