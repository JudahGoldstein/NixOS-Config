{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ssh-agents
  ];
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    authorizedKeysFiles = [ "/home/${config.name}/.ssh/authorized_keys/*" ];
  };
}
