{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    czkawka-full
  ];
  services.deluge.enable = true;
  users = {
    users.music = {
      isSystemUser = true;
      uid = 973;
      group = "media";
    };
    groups.media = {
      gid = 973;
    };
    users.${config.name}.extraGroups = [ "media" ];
  };

  services.caddy.virtualHosts = (
    inputs.virtualHosts.mkLocalVirtualHost "deluge" config.services.deluge.web.port
  );
}
