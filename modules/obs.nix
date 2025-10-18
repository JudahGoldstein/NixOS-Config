{ config, pkgs, ... }@inputs:
{
  options = {
    obs.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable the OBS Studio.";
    };
  };

  config = inputs.lib.mkIf config.obs.enable {
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = [
      "v4l2loopback"
    ];
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        input-overlay
        obs-source-clone
      ];
    };
  };
}
