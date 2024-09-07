{ config, pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = with pkgs;
    [
      sops
      age
      ssh-to-age
    ];

  sops = {
    defaultSopsFile = /etc/nixos/secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "private-keys/github" = {
        path = "/home/${config.name}/.ssh/${config.name}";
        owner = "${config.name}";
      };
      "public-keys/github" = {
        path = "/home/${config.name}/.ssh/${config.name}.pub";
        owner = "${config.name}";
      };
      "private-keys/${config.name}" = {
        path = "/home/${config.name}/.ssh/${config.name}";
        owner = "${config.name}";
      };
      "public-keys/${config.name}" = {
        path = "/home/${config.name}/.ssh/${config.name}.pub";
        owner = "${config.name}";
      };
    };
  };

}
