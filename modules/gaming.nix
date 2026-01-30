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
      protontricks.enable = config.programs.steam.enable;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      remotePlay.openFirewall = config.steam.hosting;
      dedicatedServer.openFirewall = config.steam.hosting;
      localNetworkGameTransfers.openFirewall = config.steam.hosting;
      gamescopeSession.enable = config.programs.steam.enable;
    };
    programs.gamemode.enable = config.programs.steam.enable;
    users.users.${config.name}.extraGroups = inputs.lib.mkIf config.programs.steam.enable [
      "gamemode"
    ];
    environment.systemPackages = inputs.lib.mkIf config.programs.steam.enable [ pkgs.mangohud ];
  };
}
