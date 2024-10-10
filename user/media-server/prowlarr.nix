{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
