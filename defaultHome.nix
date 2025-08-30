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
      default = "";
    };
  };
}
