{ config, pkgs, ... }@inputs:
{
  config = {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts.packages = inputs.lib.mkIf config.gnome.enable [ pkgs.gnomeExtensions.gsconnect ];
      package = inputs.pkgs-stable.firefox;
    };
  };
}
