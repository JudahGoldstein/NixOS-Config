{ config, pkgs, ... }@inputs:
{
  environment.systemPackages = with pkgs; [
    git-lfs
    gh
  ];
  hm = {
    programs.git = {
      enable = true;
      settings = {
        user.name = "Judah Goldstein";
        user.email = "yehudah.lev+github@gmail.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        safe.directory = "*";
      };
    };

    programs.lazygit = {
      enable = true;
    };
  };
}
