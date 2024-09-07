{ config, pkgs, ... }:
let
  username = "hs";
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
  
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
