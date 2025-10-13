{ config, pkgs, lib, ... }:
{
  options = {
    docker.enable = lib.mkOption {
      default = false;
      description = "Enable docker.";
    };
  };
  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    virtualisation.oci-containers.backend = "docker";
    users.users.${config.name}.extraGroups = [ "docker" ];
    hardware.nvidia-container-toolkit.enable = true;
  };
}
