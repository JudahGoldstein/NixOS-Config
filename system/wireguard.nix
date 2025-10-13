{ config, pkgs, lib, ... }:
{
  options = {
    tailscale.enable = lib.mkOption {
      default = true;
      description = "Enable wireguard host";
    };
  };
  config = lib.mkIf config.tailscale.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      disableTaildrop = true;
      extraSetFlags = [
        "--accept-routes"
        "--advertise-exit-node=false"
        "--accept-dns=false"
      ];
    };
  };
}
