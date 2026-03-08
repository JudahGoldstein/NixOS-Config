{ config, pkgs, ... }@inputs:
{
  networking.hostName = config.name;
  networking.networkmanager.enable = true;

  networking.nameservers =
    if config.services.blocky.enable then
      [ "127.0.0.1" ]
    else
      [
        "1.1.1.1"
        "1.0.0.1"
      ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  environment.systemPackages = with pkgs; [
    dig
    sshpass
  ];
}
