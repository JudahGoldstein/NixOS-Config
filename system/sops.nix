{ config, pkgs, lib, ... }:
with lib;
{
  environment.systemPackages = with pkgs;
    [
      sops
      age
      ssh-to-age
    ];

  environment.variables = {
    SOPS_EDITOR = "micro";
  };
  sops =
    {
      defaultSopsFile = "/etc/nixos/secrets.yaml";
      validateSopsFiles = false;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/root/.config/sops/age/keys.txt";
        generateKey = true;
      };

      secrets = lib.mkMerge [
        ({
          # keypairs
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
          "public-keys/${config.name}" = lib.mkForce {
            path = "/home/${config.name}/.ssh/${config.name}.pub";
            owner = "${config.name}";
          };
          # api keys and tokens
          "cloudflare-dns-api-key" =
            if config.caddy.enable == true then {
              path = "/var/lib/secrets/cloudflare-dns-api-key";
              owner = config.services.caddy.user;
              group = config.services.caddy.group;
            } else { };
          "couchdb-creds" =
            if config.services.couchdb.enable == true then {
              path = "/var/lib/secrets/couchdb-creds";
              owner = config.services.couchdb.user;
              group = config.services.couchdb.group;
            } else { };
          "copyparty-password" = {
            path = "/var/lib/secrets/copyparty-password";
            owner = "copyparty";
            group = "copyparty";
          };
        })
        ({
          # authorized keys
          "public-keys/p15" = {
            path = "/home/${config.name}/.ssh/authorized_keys/p15.pub";
            owner = "${config.name}";
          };
          "public-keys/hs" = {
            path = "/home/${config.name}/.ssh/authorized_keys/hs.pub";
            owner = "${config.name}";
          };
          "public-keys/connectbot" = {
            path = "/home/${config.name}/.ssh/authorized_keys/connectbot.pub";
            owner = "${config.name}";
          };
        })
      ];
    };
}
