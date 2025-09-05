{ config, pkgs, ... }:
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
  };


}
