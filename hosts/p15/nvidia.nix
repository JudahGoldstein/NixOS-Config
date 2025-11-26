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
    environment.systemPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
}
