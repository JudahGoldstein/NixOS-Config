{ config, pkgs, ... }@inputs:
{
  fileSystems."/bulk" = {
    device = "/dev/disk/by-uuid/5ef0952b-b607-40dc-9479-9007dea4252c";
    fsType = "ext4";
  };
  
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4c3697cf-75f6-4d54-8b08-11d36ca4399b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/BEE7-4AB3";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}
