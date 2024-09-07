{ config, pkgs, modulesPath, ... }:
let
  aliases = {
    "gethw" = "nixos-generate-config --no-filesystems --dir /mnt && clear && cat /mnt/etc/nixos/hardware-configuration.nix";
    "getage" = "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age";
  };
in
{
  imports =
    [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ];

  nixpkgs.hostPlatform = "x86_64-linux";

  users.users.nixos.hashedPassword = "$y$j9T$uM8nFY/K.shuMU.2BbMqD0$sc4/phy4qwFiSU/Ydfq4fCDvzIu3IC1DDMM7IEXbDdD";

  environment.systemPackages = with pkgs;
    [
      sops
      age
      ssh-to-age
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
