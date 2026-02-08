{ config, pkgs, ... }@inputs:
{
  longName = "Judah (HS)";

  fileSystems."/mnt/media" = {
    device = "/dev/disk/by-uuid/2dfcbe87-8cbd-4363-bdb8-a4e24558e227";
    fsType = "ext4";
    options = [
      "defaults"
      "nodiscard"
    ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.tailscale = {
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--accept-routes"
      "--advertise-exit-node=true"
      "--accept-dns=false"
    ];
  };
}
