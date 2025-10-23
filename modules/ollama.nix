{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../helpers/virtualHosts.nix inputs;
in
{
  options = {
    ollama.enable = inputs.lib.mkOption {
      default = false;
      description = "Enable ollama with webui.";
    };
  };
  config = inputs.lib.mkIf config.ollama.enable {
    services.ollama = {
      enable = true;
      host = "127.0.0.1";
      port = 11434;
      acceleration = "cuda";
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
      package = inputs.pkgs-openwebui.open-webui;
    };
    services.caddy.virtualHosts = (virtualHosts.mkPublicVirtualHost "ollama" 11435);
  };
}
