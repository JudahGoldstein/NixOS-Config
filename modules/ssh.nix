{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    ssh-agents
  ];
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
