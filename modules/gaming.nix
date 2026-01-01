{ config, pkgs, ... }@inputs:
{
  options = {
    steam.enable = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Enable steam";
    };
    steam.hosting = inputs.lib.mkOption {
      type = inputs.lib.types.bool;
      default = false;
      description = "Open ports in the firewall for steam hosting";
    };
  };

  config = inputs.lib.mkIf config.steam.enable {
    programs = {
      steam = {
        enable = true;
        protontricks.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
        remotePlay.openFirewall = config.steam.hosting;
        dedicatedServer.openFirewall = config.steam.hosting;
        localNetworkGameTransfers.openFirewall = config.steam.hosting;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
    users.users.${config.name}.extraGroups = [ "gamemode" ];
    environment.systemPackages = with pkgs; [ mangohud ];
  };
}
