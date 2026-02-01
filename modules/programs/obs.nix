{ config, pkgs, ... }@inputs:
{
  boot.extraModulePackages = inputs.lib.mkIf config.programs.obs-studio.enable [
    config.boot.kernelPackages.v4l2loopback
  ];
  boot.kernelModules = inputs.lib.mkIf config.programs.obs-studio.enable [
    "v4l2loopback"
  ];
  programs.obs-studio = {
    enable = inputs.lib.mkDefault false;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      input-overlay
      obs-source-clone
    ];
  };
}
