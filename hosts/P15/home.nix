{ config, pkgs, ... }:
let
  username = "p15";
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
  
  gnome.enable = true;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
