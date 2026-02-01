{ config, pkgs, ... }@inputs:
{
  config = {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = inputs.lib.mkIf config.services.desktopManager.gnome.enable [
        pkgs.gnomeExtensions.gsconnect
      ];
      package = inputs.pkgs-stable.firefox;
    };
  };
}
