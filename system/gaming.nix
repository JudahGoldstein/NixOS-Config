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
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = config.steam.hosting;
      dedicatedServer.openFirewall = config.steam.hosting;
      localNetworkGameTransfers.openFirewall = config.steam.hosting;
    };
  };
}
