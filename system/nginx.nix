{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    nginx.enable = mkOption {
      default = false;
      description = "Enable the ngnix proxy manager.";
    };
  };
  config = mkIf config.nginx.enable {
    virtualisation.oci-containers.containers.nginx = {
      image = "jc21/nginx-proxy-manager:latest";
      ports = [ "80:80" "443:443" "81:81" ];
      volumes = [
        "/data/nginx-proxy-manager/data:/data"
        "/data/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
      ];
    };
  };
}
