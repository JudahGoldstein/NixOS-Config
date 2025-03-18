{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  name = "p15";
  longName = "Judah (P15)";

  # TODO make a VirtualBox module
  virtualisation.virtualbox.host.enable = true;

  tailscale.enable = true;
  blocky.enable = true;

  environment.systemPackages = with pkgs; [ eclipses.eclipse-jee ]; #just for 4413

  services.fstrim.enable = true;

  fileSystems."/bulk" =
    {
      device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
      fsType = "ext4";
    };


  # Prime for Nvidia Optimus
  nvidia-prime.enable = true;
  nvidia-prime.offload = true;

  systemd.services.disableTouchscreen = {
    description = "Disable touchscreen";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = "echo 0018:2A94:D64D.0004 | tee /sys/bus/hid/drivers/hid-multitouch/unbind";
  };

  gnome.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
