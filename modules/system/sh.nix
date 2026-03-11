{ config, pkgs, ... }@inputs:
let
  myAliases = {
    "ll" = "ls -la";
    "la" = "ls -a";
    "l" = "ls";
    "c" = "clear";
    ".." = "cd ..";
    "..." = "cd ../..";
    "lg" = "lazygit";
    "nix-update" =
      "cd /etc/nixos/ && git fetch --all && git reset --hard origin/main && nh os boot && nh clean all --keep 3 && cd -";
    "nix-update-ssh" =
      "cd /etc/nixos/ && git fetch --all && git reset --hard origin/main && nh os boot --no-nom && nh clean all --keep 3 && systemctl reboot";
  };
in
{
  programs.bash.shellAliases = myAliases;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ ];
    };
    interactiveShellInit = "source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh";
    shellAliases = myAliases;
  };
  environment.systemPackages = with pkgs; [
    tldr
    zsh-nix-shell
    parallel
    psmisc
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
