{ config, pkgs, lib, ... }:
let
  virtualHosts = import ../caddy/virtualHosts.nix { inherit lib; };
in
with lib;
{
  config = mkIf config.media-server.enable {
    services.copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = 3923;
      };
      accounts = { test.passwordFile = "/etc/nixos/hosts/p15/test"; };
      volumes = { };
      package = (pkgs.copyparty.override {
        withThumbnails = true;
        withFastThumbnails = true;
      });
    };
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "copyparty" 3923);
  };
}
