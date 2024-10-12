{ config, pkgs, lib, ... }:
{
  options = {
    obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the OBS Studio streaming software";
    };
  };

  config = lib.mkIf (config.obs.enable == true) {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        input-overlay
      ];
    };
  };
}
