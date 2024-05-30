{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
    [
      # Editors
      obsidian
      libreoffice

      # Audio/Video
      easyeffects
      gimp
      audacity
      vlc

      # Communication
      zoom-us
      discord

      # Security
      bitwarden-desktop
      
      # Misc
      plover.dev
      nerdfonts
    ];

  #fix for application picker
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
