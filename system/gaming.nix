{ config, pkgs, lib, ... }:
{
  options = {
    steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable steam";
    };
    steam.hosting = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open ports in the firewall for steam";
    };
  };

  config = lib.mkIf config.steam.enable {
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
