{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    environment.systemPackages = with pkgs; [ calibre ];
    services.calibre-web = {
      enable = true;
      openFirewall = true;
      options = {
        calibreLibrary = "/mnt/media/library/";
        enableBookUploading = true;
      };
      listen = {
        ip = "0.0.0.0";
        port = 51852;
      };
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "library" 51852);
  };
}
