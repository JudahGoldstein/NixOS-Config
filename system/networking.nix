{ config, pkgs, ... }:
{
  networking.hostName = config.name;
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [ ivpn ];
  services.ivpn.enable = true;
  services.openssh.enable = true;
}
