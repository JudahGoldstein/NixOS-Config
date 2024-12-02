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
    "nix-update" = "cd /etc/nixos/ && nix flake update && git pull && nh os boot . -- --impure && nh home switch . && nh clean all --keep 3 && git commit -m 'flake' flake.lock && git push";
    "ligma"="echo balls";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      custom = "/etc/nixos/user/shell/custom";
      theme = "gruvbox";
      plugins = [ ];
    };
  };
}
