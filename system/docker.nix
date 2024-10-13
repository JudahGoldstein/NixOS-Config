{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    docker.enable = mkOption {
      default = false;
      description = "Enable docker.";
    };
  };
  config = mkIf config.docker.enable {
    virtualisation.docker.enable = true;
    hardware.nvidia-container-toolkit.enable = true;
  };
}
