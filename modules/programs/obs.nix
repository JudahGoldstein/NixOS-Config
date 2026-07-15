{ config, pkgs, ... }@inputs:
{
  programs.obs-studio = {
    enable = inputs.lib.mkDefault false;
    enableVirtualCamera = config.programs.obs-studio.enable;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      obs-source-clone
      wlrobs
    ];
  };
}
