{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
    [
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

      # chrome for testing
      chromium
    ];

  #fix for application picker
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
