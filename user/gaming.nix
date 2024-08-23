{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    steam.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable steam";
    };
    steam.hosting = mkOption {
      type = types.bool;
      default = false;
      description = "Open ports in the firewall for steam";
    };
  };

  config = mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay = mkIf config.steam.hosting { openFirewall = true; };
      dedicatedServer = mkIf config.steam.hosting { openFirewall = true; };
      localNetworkGameTransfers = mkIf config.steam.hosting { openFirewall = true; };
    };
  };
}
