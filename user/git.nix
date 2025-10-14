{ config, pkgs, ... }@inputs:
{
  programs.git = {
    enable = true;
    userName = "Judah Goldstein";
    userEmail = "yehudah.lev+github@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      safe.directory = "*";
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
