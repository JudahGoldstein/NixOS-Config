{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf media-server.enable {
    services.bazarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
