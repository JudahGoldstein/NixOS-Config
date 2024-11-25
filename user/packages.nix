{ config, pkgs, ... }:
{
  home.packages = with pkgs;
    [
      # Communication
      zoom-us
      (pkgs.discord.override {
        # withOpenASAR = true; #causes error un updates
        withVencord = true;
      })

      # Security
      bitwarden-desktop

      # Misc
      plover.dev
      nerdfonts

      # chrome for testing
      chromium

      remmina
    ];

  #fix for application picker
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
