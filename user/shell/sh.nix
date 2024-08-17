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
    "nix-update" = "cd ~/NixOS-Config && git pull && nh os boot --update && nh home switch && nh clean all --keep 3 && git commit -m 'flake' flake.lock && git push"; #this is definitely not something to keep, but while getting an initial setup it's usefull. should be refacfored into a module.
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
      custom = "$HOME/NixOS-Config/user/shell/custom";
      theme = "gruvbox";
      plugins = [ ];
    };
  };
}
