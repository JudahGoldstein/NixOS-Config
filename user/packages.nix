{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs;
    [
      obsidian
      plover.dev
      discord
      bitwarden-desktop
      libreoffice
      plover.dev
      nerdfonts
      easyeffects
      zoom-us
      vlc
      megasync
      python3Full
      nil
      nixpkgs-fmt
    ];

  programs = {
    direnv.enable = true;
    vscode.enable = true;
  };

  #fix for application picker
  programs.bash.enable = true;
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
}
