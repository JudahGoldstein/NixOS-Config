{ config, pkgs, lib, nixarr, ... }:
with lib;
{
  options = {
    arr.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Arr Suite";
    };
  };
  config = lib.mkIf config.arr.enable { };
}
