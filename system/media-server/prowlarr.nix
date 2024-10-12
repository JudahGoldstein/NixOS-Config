{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
