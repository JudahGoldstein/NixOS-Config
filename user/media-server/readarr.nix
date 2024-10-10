{ config, pkgs, lib, ... }:
with lib;
{
  config = mkIf media-server.enable {
    services.readarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/readarr";
    };
  };
}
