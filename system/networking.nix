{ config, pkgs, lib, ... }:
with lib;
{
  networking.hostName = config.name;
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs;
    [
      ivpn
      dig
    ];
  services.ivpn.enable = true;
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
