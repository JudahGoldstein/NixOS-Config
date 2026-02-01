{ config, pkgs, ... }@inputs:
{
  hm = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Judah Goldstein";
        user.email = "yehudah.lev+github@gmail.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        safe.directory = "*";
      };
    };
    programs.gh.enable = true;
    programs.lazygit = {
      enable = true;
    };
  };
}
