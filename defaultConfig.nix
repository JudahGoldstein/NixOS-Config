{ config, pkgs, ... }@inputs:
{

  options = {
    name = inputs.lib.mkOption {
      type = inputs.lib.types.str;
      description = "The hostname for this configuration";
    };
  };

  config = {
    services.fstrim.enable = true;
    services.fwupd.enable = true;
    environment.systemPackages = with pkgs; [ nixos-facter ];

    hm = {
      programs.home-manager.enable = true;
      home.username = config.name;
      home.homeDirectory = "/home/${config.name}";
      home.file = { };
      home.stateVersion = "23.11";
      home.sessionVariables = {
        EDITOR = "micro";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        TERM = "kitty";
      };
    };
    system.stateVersion = "23.11";
  };
}
