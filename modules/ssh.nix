{ config, pkgs, ... }@inputs:
{
  hm.services.ssh-agent.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ config.name ];
      PermitRootLogin = "no";
    };
    authorizedKeysFiles = [ "/home/${config.name}/.ssh/authorized_keys/*" ];
  };
}
