{ config, pkgs, ... }:
let
  username = "v14";
  homeDirectory = "/home/" + username;
in
{
  imports =
    [
      ../../defaultHome.nix
    ];

  home.username = username;
  home.homeDirectory = homeDirectory;

  home.file = { };

  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  gnome.enable = true;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
