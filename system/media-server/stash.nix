{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    stash.enable = mkOption {
      default = false;
      description = "Enable stash.";
    };
  };
  config = mkIf config.stash.enable {
    environment.systemPackages = with pkgs;[stash];
    systemd.services.stash = {
      description = "Stash media server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.stash}/bin/stash";
        User = "root";
        Group = "root";
        Restart = "always";
      };
    };
  };
}