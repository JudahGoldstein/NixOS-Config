{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    ssh-agents
  ];
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
