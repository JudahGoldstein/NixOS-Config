{ config, pkgs, lib, ... }:
with lib;
{
  options = {
    sops-name = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = {
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
        "private-keys/${config.sops-name}" = {
          path = "/home/${config.sops-name}/.ssh/${config.sops-name}";
          owner = "${config.sops-name}";
        };
        "public-keys/${config.sops-name}" = {
          path = "/home/${config.sops-name}/.ssh/${config.sops-name}.pub";
          owner = "${config.sops-name}";
        };
      };
    };
  };
}
