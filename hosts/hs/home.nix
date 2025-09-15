{ config, pkgs, ... }:
{
  imports =
    [
      ../../defaultHome.nix
    ];

  home.username = config.name;
  home.homeDirectory = "/home/${config.name}";

  home.file = { };

  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    TERM = "kitty";
  };
  
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
