{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-prime.nix
      ./bootloader.nix
      ../../defaultConfig.nix
    ];

  name = "p15";
  longName = "Judah (P15)";

  blocky.enable = true;
  tailscale.enable = true;

  services.fstrim.enable = true;

  fileSystems."/bulk" =
    {
      device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
      fsType = "ext4";
    };

  # Prime for Nvidia Optimus
  nvidia-prime.enable = true;
  nvidia-prime.offload = true;

  gnome.enable = true;

  services.fprintd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
