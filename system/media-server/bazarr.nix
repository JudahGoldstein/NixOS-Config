{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.bazarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
