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

  swapDevices = [{
    device = "/swapfile";
    size = 128 * 1024; # 128GB
  }];


  boot.kernelPackages = pkgs.linuxPackages_latest;

  stylix.enable = inputs.lib.mkForce false;

  services.tailscale = {
    useRoutingFeatures = "both";
    extraSetFlags = [
      "--advertise-exit-node"
    ];
  };
}
