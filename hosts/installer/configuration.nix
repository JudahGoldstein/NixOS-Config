{ config, pkgs, modulesPath, lib, ... }:
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

  users.users.nixos = {
    password = "arst";
    hashedPassword = lib.mkForce null;
    hashedPasswordFile = lib.mkForce null;
    initialPassword = lib.mkForce null;
    initialHashedPassword = lib.mkForce null;
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak";
  };
  
  environment.systemPackages = with pkgs;
    [
      sops
      age
      ssh-to-age
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "23.11";
}
