{ config, pkgs, ... }@inputs:
{
  services.soft-serve = {
    enable = true;
    settings = {
      name = "private repos";
      log_format = "text";
      ssh = {
        listen_addr = ":23231";
        public_url = "ssh://git.ts.janjuta.org:";
      };
    };
  };
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "git" 23231);
}
