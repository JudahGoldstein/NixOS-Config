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

  # systemd service to start firefox in headless mode for automation before the user logs in
  systemd.services.firefox-headless = {
    description = "Firefox Headless";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      user = "${config.name}";
      ExecStart = "${pkgs.firefox}/bin/firefox --headless -P default";
      Restart = "always";
      RestartSec = "5s";
    };
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
