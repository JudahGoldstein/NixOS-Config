{ ... }:
{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "1M";
            type = "EF02"; # for grub MBR
          };
          ESP = {
            type = "EF00";
            size = "1G";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/persist" = {
                  mountOptions = [
                    "subvol=persist"
                    "noatime"
                  ];
                  mountpoint = "/persist";
                };
                "/nix" = {
                  mountOptions = [
                    "subvol=nix"
                    "noatime"
                  ];
                  mountpoint = "/nix";
                };
              };
            };
          };
          swap = {
            size = "6G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=50%"
        "mode=755"
      ];
    };
  };
}
