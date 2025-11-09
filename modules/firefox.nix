{ config, pkgs, ... }@inputs:
{
  config = {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.gsconnect = config.gnome.enable;
      package = inputs.pkgs-stable.firefox;
    };
  };
}
