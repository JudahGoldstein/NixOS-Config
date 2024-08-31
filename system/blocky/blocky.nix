{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    blocky.enable = mkOption {
      type = types.bool;
      default = false;
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
          blackLists = {
            multi = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro.plus.txt" ];
            scams = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/fake.txt" ];
            threatIntel = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/dnsmasq/tif.txt" ];
            blacklist = ./blacklist.txt;
          };
          whiteLists = {
            # Piracy is bad kids
            notPiracy = [ "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/anti.piracy.txt" "https://blocklistproject.github.io/Lists/adguard/piracy-ags.txt" ];
            whitelist = ./whitelist.txt;
          };
          clientGroupsBlock = {
            default = [ "multi" "scams" "threatIntel" "blacklist" ];
          };
        };
      };
    };

  };
}
