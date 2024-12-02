{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;
      dataDir = "/var/lib/sonarr";
      package = pkgs.sonarr;
    };
    nixpkgs.config.permittedInsecurePackages = [
      "aspnetcore-runtime-wrapped-6.0.36"
      "aspnetcore-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
    ];
    services.caddy.virtualHosts."sonarr.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8989
      '';
    };
  };
}
