{ config, pkgs, ... }@inputs:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    disableTaildrop = true;
    useRoutingFeatures = "client";
    extraSetFlags = inputs.lib.mkDefault [
      "--accept-dns=false"
    ];
  };
}
