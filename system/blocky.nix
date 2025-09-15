{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    blocky.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable blocky";
    };
  };
  config = lib.mkIf config.blocky.enable {
    services.blocky = {
      enable = true;
      settings = {
        ports.dns = 53;
        upstreams.groups.default = [
          "https://one.one.one.one/dns-query"
        ];
        bootstrapDns = {
          upstream = "https://one.one.one.one/dns-query";
          ips = [ "1.1.1.1" "1.0.0.1" ];
        };
        blocking = {
          denylists = {
            multi = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro.plus.txt" "https://big.oisd.nl/domainswild" ];
            scams = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/fake.txt" ];
            threatIntel = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/dnsmasq/tif.txt" ];
            mobile = [ "https://adaway.org/hosts.txt" ];
          };
          allowlists = {
            # Piracy is bad kids
            notPiracy = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/anti.piracy.txt" "https://blocklistproject.github.io/Lists/adguard/piracy-ags.txt" ];
          };
          clientGroupsBlock = {
            default = [ "multi" "scams" "threatIntel" "mobile" ];
          };
        };
      };
    };
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];
    networking.nameservers = [ "127.0.0.1" ];
  };
}
