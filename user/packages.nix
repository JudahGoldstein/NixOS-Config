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
      nerdfonts
      remmina

      # chrome for testing
      chromium

      #temporary, do not commit to git
      shotcut
    ];

  #fix for application picker
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
