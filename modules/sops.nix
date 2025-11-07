{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
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

    secrets = inputs.lib.mkMerge [
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
        "public-keys/${config.name}" = inputs.lib.mkForce {
          path = "/home/${config.name}/.ssh/${config.name}.pub";
          owner = "${config.name}";
        };
        # api keys and tokens
        "cloudflare-dns-api-key" = inputs.lib.mkIf (config.services.caddy.enable) {
          path = "/var/lib/secrets/cloudflare-dns-api-key";
          owner = config.services.caddy.user;
          group = config.services.caddy.group;
        };
        "github-token" = {
          path = "/var/lib/secrets/github-token";
          owner = "${config.name}";
        };
        "couchdb-creds" = inputs.lib.mkIf (config.services.couchdb.enable) {
          path = "/var/lib/secrets/couchdb-creds";
          owner = config.services.couchdb.user;
          group = config.services.couchdb.group;
        };
        "copyparty-password" = inputs.lib.mkIf (config.services.copyparty.enable) {
          path = "/var/lib/secrets/copyparty-password";
          owner = config.services.copyparty.user;
          group = config.services.copyparty.group;
        };
        "nutmon-password" = inputs.lib.mkIf config.power.ups.enable {
          path = "/var/lib/secrets/nutmon-password";
          owner = "nutmon";
          group = "nutmon";
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
