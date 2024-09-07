{ config, pkgs, lib, ... }:
with lib;
{
  imports =
    [
      ./user/shell/sh.nix
      ./user/firefox.nix
      ./user/packages.nix
      ./user/git.nix
      ./user/shell/terminal/terminal.nix
      ./user/desktop/desktop.nix
      ./user/syncthing.nix
      ./user/obs.nix
      ./user/vscode.nix
      ./user/text-editors.nix
      ./user/nixvim.nix
      ./user/audio-video.nix
    ];
  options = {
    name = mkOption {
      type = types.str;
      default = "";
    };
  };
}
