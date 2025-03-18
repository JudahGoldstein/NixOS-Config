{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  options = {
    tailscale.enable = mkOption {
      default = false;
      description = "Enable wireguard host";
    };
  };
  config = mkIf config.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      extraSetFlags = [ "--advertise-exit-node" ];
    };
  };
}
