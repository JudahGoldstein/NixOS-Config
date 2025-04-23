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

  blocky.enable = true;

  # Device specific Tailscale configuration
  tailscale.enable = true;
  services.tailscale = {
    useRoutingFeatures = "client";
  };
  

  services.fstrim.enable = true;

  fileSystems."/bulk" =
    {
      device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
      fsType = "ext4";
    };


  # Prime for Nvidia Optimus
  nvidia-prime.enable = true;
  nvidia-prime.offload = true;

  #udev rule for disabling touchscreen
  services.udev.extraRules = ''
  ACTION!="remove", KERNEL=="event[0-9]*", ENV{ID_VENDOR_ID}=="2A94", ENV{ID_MODEL_ID}=="D64D", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';

  gnome.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
