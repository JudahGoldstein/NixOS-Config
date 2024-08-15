{ config, pkgs, lib, inputs, nixvim, ... }:
with lib;{
  programs.nixvim = {
    enable = true;
    vimAlias = true;
  };
}
