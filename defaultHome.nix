{ config, pkgs, ... }@inputs:
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
    name = inputs.lib.mkOption {
      type = inputs.lib.types.str;
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
    gnome.enable = inputs.lib.mkDefault true;
  };
}
