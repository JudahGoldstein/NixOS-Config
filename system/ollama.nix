{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  options = {
    ollama.enable = mkOption {
      default = false;
      description = "Enable ollama with webui.";
    };
  };
  config = mkIf config.ollama.enable {
    services.ollama = {
      enable = true;
      host = "127.0.0.1";
      port = 11434;
      acceleration = "cuda";
      package = pkgs.ollama;
    };
    services.open-webui = {
      enable = true;
      port = 11435;
      openFirewall = true;
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      };
      package = pkgs.open-webui;
    };
    services.caddy.virtualHosts."ollama.janjuta.duckdns.org" = mkIf config.caddy.enable {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:11435
      '';
    };
    services.caddy.virtualHosts."ollama.jantun.duckdns.org" = mkIf config.caddy.enable {
      useACMEHost = "jantun.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:11435
      '';
    };
  };
}
