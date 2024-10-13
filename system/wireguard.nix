{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  options = {
    wireguard.enable = mkOption {
      default = false;
      description = "Enable wireguard host";
    };
  };
  config = mkIf config.wireguard.enable {
    # TODO: Add wireguard configuration
  };
}
