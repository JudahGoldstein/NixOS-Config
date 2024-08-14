{ config, pkgs, lib, inputs, nixvim, ... }:
with lib;{
  imports = [ nixvim.homeManagerModules.nixvim ];
  programs.nixvim = {
    enable = true;
  };
}
