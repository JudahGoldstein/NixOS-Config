{ config, pkgs, ... }@inputs:
{
  boot = {
    loader = {
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
        extraFiles = {
          "netbootxyz.efi" = "${pkgs.netbootxyz-efi}";
        };
        extraEntries = ''
          menuentry "netbootxyz" {
            chainloader /netbootxyz.efi
          }
        '';
      };
    };
    initrd.verbose = false;
  };
}
