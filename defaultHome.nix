{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./user/git.nix
      ./user/desktop/desktop.nix
      ./user/nixvim.nix
      ./user/audio-video.nix
      ./user/cyber.nix
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
