{ config, pkgs, ... }@inputs:
{
  options = {
    steam.hosting = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Open ports in the firewall for steam hosting features (remote play, dedicated servers, local network game transfers).";
    };
  };

  config = {
    programs.steam = {
      enable = inputs.lib.mkDefault false;
      protontricks.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = config.steam.hosting;
      dedicatedServer.openFirewall = config.steam.hosting;
      localNetworkGameTransfers.openFirewall = config.steam.hosting;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
    users.users.${config.name}.extraGroups = [ "gamemode" ];
    environment.systemPackages = with pkgs; [ mangohud ];
  };
}
