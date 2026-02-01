{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    vlc
    ffmpeg-headless
  ];
}
