{ config, pkgs, lib, stable-diffusion-webui-nix, ... }:
with lib;
{
  options = {
    forge.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Forge AI";
    };
  };
  config = mkIf config.forge.enable {
    nixpkgs.overlays = [ stable-diffusion-webui-nix.overlays.default ];
    environment.systemPackages = [ pkgs.stable-diffusion-webui.forge.cuda ];
    systemd.services.forge = {
      description = "Forge WebUI Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.stable-diffusion-webui.forge.cuda}/bin/stable-diffusion-webui --cuda-malloc";
        Restart = "always";
        RestartSec = 10;
        User = config.name;
        EnvironmentFile = "/home/${config.name}/env.env"; #printenv > ~/env.env
      };
    };
    services.caddy.virtualHosts."forge.janjuta.duckdns.org" = mkIf config.caddy.enable {
      useACMEHost = "janjuta.duckdns.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:7860
      '';
    };
  };
}
