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
    systemd.services.wg-easy = {
      description = "Wireguard easy";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.docker}/bin/docker run --detach --name wg-easy --env LANG=en --env WG_HOST=jantun.duckdns.org --env WG_DEFAULT_DNS=10.0.0.10 --env PORT=51821 --env WG_PORT=51820 --env WG_DEVICE=eno1 --volume /etc/wireguard:/etc/wireguard --publish 51820:51820/udp --publish 51821:51821/tcp --cap-add NET_ADMIN --cap-add SYS_MODULE --sysctl 'net.ipv4.conf.all.src_valid_mark=1' --sysctl 'net.ipv4.ip_forward=1' --restart unless-stopped ghcr.io/wg-easy/wg-easy:latest";
        User = "root";
        Group = "root";
        Restart = "always";
      };
    };
  };
}
