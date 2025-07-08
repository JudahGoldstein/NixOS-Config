{ config, pkgs, lib, ... }:
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
      disableTaildrop = true;
      extraSetFlags = [
        "--accept-routes"
        "--advertise-exit-node=false" 
        "--accept-dns=false"     
        ];
    };
  };
}
