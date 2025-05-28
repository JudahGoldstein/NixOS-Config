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
    virtualisation.oci-containers.backend = "docker";
    hardware.nvidia-container-toolkit.enable = true;
  };
}
