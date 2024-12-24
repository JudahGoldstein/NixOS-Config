{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./user/git.nix
      ./user/shell/terminal/terminal.nix
      ./user/desktop/desktop.nix
      ./user/syncthing.nix
      ./user/obs.nix
      ./user/vscode.nix
      ./user/text-editors.nix
      ./user/nixvim.nix
      ./user/audio-video.nix
      ./user/cyber.nix
      ./user/ssh.nix
    ];
  options = {
    name = mkOption {
      type = types.str;
      default = "";
    };
  };
}
