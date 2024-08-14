{ config, pkgs, lib, inputs, ... }:
with lib;{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  options = {
    nixvim.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable nixvim";
    };
  };
  config = {
    programs.nixvim = {
      enable = true;
    };
  };
}
