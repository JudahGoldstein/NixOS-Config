{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      custom = "/etc/nixos/user/shell/custom";
      theme = "gruvbox";
      plugins = [ ];
    };
  };
}
