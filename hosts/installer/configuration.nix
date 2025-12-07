{ config, pkgs, ... }@inputs:
let
  aliases = {
    "gethw" =
      "sudo nixos-generate-config --no-filesystems --dir /mnt && sudo cat /mnt/hardware-configuration.nix";
    "getage" = "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age";
  };
in
{
  imports = [
    "${inputs.modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.modulesPath}/installer/cd-dvd/channel.nix"
    ../../modules/gnome.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  services.openssh.enable = true;
  gnome.enable = true;
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  users.users.nixos = {
    password = "arst";
    hashedPassword = inputs.lib.mkForce null;
    hashedPasswordFile = inputs.lib.mkForce null;
    initialPassword = inputs.lib.mkForce null;
    initialHashedPassword = inputs.lib.mkForce null;
    openssh.authorizedKeys.keys = 
    [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICfe84n5+9IQpH1dhqOgoJrPcNeHZKHYziYFIWYZt+F7 yehudah.lev@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBIXo+wrGI4775CY4wT2LbuoWigKKjiKWu8S6EWzdn/6 yehudah.lev@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ6pp2JPSB1FeDX/AyOISOKvZe4YDuPP//9GmzZar518 yehudah.lev@gmail.com"
    ];
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

  environment.systemPackages = with pkgs; [
    git
    micro
    sops
    age
    ssh-to-age
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
