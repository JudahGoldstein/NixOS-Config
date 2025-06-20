{ config, pkgs, lib, ... }:
with lib;
{
  networking.hostName = config.name;
  networking.networkmanager.enable = true;

  networking.nameservers =
    if config.blocky.enable
    then [ "127.0.0.1" ]
    else [ "1.1.1.1" "1.0.0.1" ];
  environment.systemPackages = with pkgs;
    [
      dig
      sshpass
    ];
  services.openssh.enable = true;
  services.sshd.enable = true;

}
