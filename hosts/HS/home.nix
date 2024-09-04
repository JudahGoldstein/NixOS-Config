{ config, pkgs, ... }:
let
  username = "HS";
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
  programs.nh.flake=/etc/nixos;

  home.sessionVariables = {
    EDITOR = "micro";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    TERM = "kitty";
  };
  
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
