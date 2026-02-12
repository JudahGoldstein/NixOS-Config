{ config, pkgs, ... }@inputs:
{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = inputs.lib.mkIf config.services.desktopManager.gnome.enable [
      pkgs.gnomeExtensions.gsconnect
    ];
  };
  environment.systemPackages = with pkgs; [
    chromium
  ];
}
