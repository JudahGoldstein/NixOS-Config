{ config, pkgs, ... }:
let
  myAliases = {
    "ll" = "ls -la";
    "la" = "ls -a";
    "l" = "ls";
    "c" = "clear";
    "e" = "exit";
    ".." = "cd ..";
    "..." = "cd ../..";
    "lg" = "lazygit";
    "v" = "nvim";
    "neofetch" = "nerdfetch";
    "nix-update" = "cd /etc/nixos/ && git pull && nix flake update && nh os boot && nh home switch && nh clean all --keep 3 && git commit -m 'flake' flake.lock && git push";
    "ligma" = "echo balls";
  };
in
{
  programs.bash.shellAliases = myAliases;
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
