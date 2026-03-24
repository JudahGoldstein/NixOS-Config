{ config, pkgs, ... }@inputs:
{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = false;
      efiSupport = true;
      copyKernels = true;
      ipxe = {
        netbootxyz = ''
          #!ipxe
          dhcp
          chain --autofree https://boot.netboot.xyz
        '';
        nixInstaller = ''
          #!ipxe
          chain https://github.com/nix-community/nixos-images/releases/download/nixos-unstable/netboot-x86_64-linux.ipxe
        '';
      };
    };
  };
}
