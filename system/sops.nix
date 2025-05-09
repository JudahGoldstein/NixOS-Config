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
  sops = {
    defaultSopsFile = "/etc/nixos/secrets.yaml";
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
      "duckdns-token" =
        if config.caddy.enable == true then {
          path = "/var/lib/secrets/duckdns-token";
          owner = config.services.caddy.user;
          group = config.services.caddy.group;
        } else { };
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
    };
  };
}
