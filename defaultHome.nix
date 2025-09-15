{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./user/git.nix
      ./user/discord.nix
      ./user/desktop/desktop.nix
      ./user/ssh.nix
      ./user/kitty.nix
    ];
  options = {
    name = mkOption {
      type = types.str;
      description = "The hostname/username for this configuration";
    };
  };

  config = {
    home.username = config.name;
    home.homeDirectory = "/home/${config.name}";
    home.file = { };
    home.stateVersion = "23.11";

    home.sessionVariables = {
      EDITOR = "micro";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      TERM = "kitty";
    };

    programs.home-manager.enable = true;
    gnome.enable = lib.mkDefault true;
  };
}
