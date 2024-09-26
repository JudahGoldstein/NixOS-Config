{ config, pkgs, ... }:
{
  imports =
    [
      ../../defaultHome.nix
    ];

  name = "p15";

  home.username = config.name;
  home.homeDirectory = "/home/${config.name}";

  home.file = { };

  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  gnome.enable = true;

  cyber.enable = true;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
