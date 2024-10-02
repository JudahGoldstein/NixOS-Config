{ config, pkgs, ... }:
{
  networking.hostName = config.name;
  networking.networkmanager.enable = true;
  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [ ivpn ];
}
