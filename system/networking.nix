{ config, pkgs, ... }:
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

  # networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  # services.resolved = {
  #   enable = true;
  #   dnssec = "true";
  #   domains = [ "~." ];
  #   fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  #   dnsovertls = "true";
  # };
}
