{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  networking.networkmanager.enable = true;
  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [ ivpn ];
}
