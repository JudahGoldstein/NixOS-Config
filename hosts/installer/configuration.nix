{ config, pkgs, modulesPath, lib, ... }:
let
  aliases = {
    "gethw" = "sudo nixos-generate-config --no-filesystems --dir /mnt && sudo cat /mnt/hardware-configuration.nix";
    "getage" = "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age";
  };
in
{
  imports =
    [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      "${modulesPath}/installer/cd-dvd/channel.nix"
      ../../system/desktop/gnome.nix
    ];

  nixpkgs.hostPlatform = "x86_64-linux";

  services.openssh.enable = true;
  gnome.enable = true;
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

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
  console.useXkbConfig = true;

  programs.bash = {
    shellAliases = aliases;
  };

  environment.systemPackages = with pkgs;
    [
      git
      micro
      sops
      age
      ssh-to-age
    ];

  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
