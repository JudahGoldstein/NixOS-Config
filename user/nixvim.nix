{ config, pkgs, lib, inputs, nixvim, ... }:
with lib;{
  options = {
    nixvim.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable nixvim";
    };
  };
  
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim = {
      enable = true;
      vimAlias = true;
    };
  };
}
