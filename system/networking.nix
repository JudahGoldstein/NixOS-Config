{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  openssh.authorizedKeys.keys =
    [
      (builtins.readFile ../hosts/public-keys/p15.pub)
    ];
  networking.networkmanager.enable = true;
  services.ivpn.enable = true;
  environment.systemPackages = with pkgs; [ ivpn ];
}
