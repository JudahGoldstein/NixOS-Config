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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
