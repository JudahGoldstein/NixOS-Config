{ config, pkgs, ... }:
let 
    username = "judah";
    homeDirectory = "/home/" + username;
in
{
    imports =
    [
    ./user/shell/sh.nix
    ./user/browser/firefox.nix
    ./user/packages.nix
    ./user/git.nix
    ./user/shell/terminal/terminal.nix
    ];

    home.username = username;
    home.homeDirectory = homeDirectory;

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {};

    home.sessionVariables = {
        EDITOR = "micro";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        TERM = "kitty";
    };

    home.stateVersion = "23.11"; # Please read the comment before changing.

    programs.home-manager.enable = true;
}
