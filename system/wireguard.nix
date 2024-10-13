{ config, pkgs, pkgs-unstable, lib, ... }:
with lib;
{
  options = {
    wireguard.enable = mkOption {
      default = false;
      description = "Enable wireguard host";
    };
  };
  config = mkIf config.wireguard.enable {
    virtualisation.oci-containers.containers.wg-easy = {
      image = "ghcr.io/wg-easy/wg-easy:latest";
      ports = [ "51820:51820/udp" "51821:51821/tcp" ];
      volumes = [
        "/etc/wireguard:/etc/wireguard"
      ];
      environment = {
        LANG = "en";
        WG_HOST = "jantun.duckdns.org";
        WG_PORT = "51820";
        WG_DEFAULTDNS = "janjuta.duckdns.org";
      };
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--cap-add=SYS_MODULE"
        "--cap-add=NET_RAW"
        "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
        "--sysctl=net.ipv4.ip_forward=1"
      ];
     };
  };
}
