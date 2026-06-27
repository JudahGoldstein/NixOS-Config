{ config, pkgs, ... }@inputs:
{
  programs.ssh = {
    startAgent = false;
    extraConfig = ''
      Host *
        AddKeysToAgent yes
    '';
  };
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
