{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  config = mkIf config.media-server.enable {
    nixpkgs.overlays = with pkgs; [
      (
        final: prev:
          {
            jellyfin-web = prev.jellyfin-web.overrideAttrs (finalAttrs: previousAttrs: {
              installPhase = ''
                runHook preInstall

                # this is the important line
                sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

                mkdir -p $out/share
                cp -a dist $out/share/jellyfin-web

                runHook postInstall
              '';
            });
          }
      )
    ];

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      cacheDir = "/var/cache/jellyfin";
      dataDir = "/var/lib/jellyfin";
      logDir = "/var/log/jellyfin";
      package = pkgs.jellyfin;
    };

    services.caddy.virtualHosts."jellyfin.janjuta.duckdns.org" = {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
    services.caddy.virtualHosts."jellyfin.jantun.duckdns.org" = {
      useACMEHost = "jantun.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8096
      '';
    };
  };
}
