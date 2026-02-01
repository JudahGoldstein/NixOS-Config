{ config, pkgs, ... }@inputs:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    disableTaildrop = true;
    useRoutingFeatures = inputs.lib.mkDefault "client";
    extraSetFlags = inputs.lib.mkDefault [
      "--accept-dns=false"
    ];
  };
}
