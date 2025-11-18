{ config, pkgs, ... }@inputs:
{
  services.tailscale = {
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--accept-routes"
      "--advertise-exit-node=true"
      "--accept-dns=false"
    ];
  };
}
