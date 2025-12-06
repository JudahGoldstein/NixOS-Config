{ config, pkgs, ... }@inputs:
{

  environment.systemPackages = with pkgs; [
    vlc
    ffmpeg-headless
  ];
  hm.services.easyeffects = {
    enable = true;
    package = pkgs.easyeffects;
  };
}
