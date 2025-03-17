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
  programs.ssh = mkIf config.kde.enable {
    startAgent = true;
    enableAskPassword = true;
    askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
  };

  environment.variables = mkIf config.kde.enable {
    SSH_ASKPASS_REQUIRE = "prefer";
  };

}
