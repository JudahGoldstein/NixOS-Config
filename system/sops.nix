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
      keyFile = "/root/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      "private-keys/github" = {
        path = "/home/${config.name}/.ssh/github";
        owner = "${config.name}";
      };
      "public-keys/github" = {
        path = "/home/${config.name}/.ssh/github.pub";
        owner = "${config.name}";
      };
      "private-keys/${config.name}" = {
        path = "/home/${config.name}/.ssh/${config.name}";
        owner = "${config.name}";
      };
      "public-keys/p15" =
        if config.name == "p15" then {
          path = "/home/${config.name}/.ssh/${config.name}.pub";
          owner = "${config.name}";
        } else { };
      "public-keys/hs" =
        if config.name == "hs" then {
          path = "/home/${config.name}/.ssh/${config.name}.pub";
          owner = "${config.name}";
        } else { };
      "wireguard-private/hs" =
        if config.name == "hs" then {
          path = "/etc/wireguard/wg-pub";
          owne= "${config.name}";
        } else { };
        "wireguard-public/hs" =
        if config.name == "hs" then {
          path = "/etc/wireguard/wg";
          owne= "${config.name}";
        } else { };
    };
  };
}
