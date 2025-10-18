{ config, pkgs, ... }@inputs:
{
  options = {
    docker.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable docker.";
    };
  };
  config = inputs.lib.mkIf config.docker.enable {
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
