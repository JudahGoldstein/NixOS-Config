{ config, pkgs, ... }:
{
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
  };

  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [ ivpn ];
}
