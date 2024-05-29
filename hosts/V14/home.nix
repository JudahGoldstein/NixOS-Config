{ config, pkgs, ... }:
let
  username = "v14";
  homeDirectory = "/home/" + username;
in
{
  imports =
    [
      ../../user/shell/sh.nix
      ../../user/browser/firefox.nix
      ../../user/packages.nix
      ../../user/git.nix
      ../../user/shell/terminal/terminal.nix
      ../../user/desktop/desktop.nix
      ../../user/syncthing.nix
      ../../user/obs.nix
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
  terminal = "kitty";

  gnome.enable = true;

  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
