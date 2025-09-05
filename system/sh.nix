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
    "neofetch" = "fastfetch";
    "nix-update" = "cd /etc/nixos/ && git pull && nix flake update && nh os boot && nh clean all --keep 3 && git commit -m 'flake' flake.lock && git push && cd -";
    "ligma" = "echo balls";
  };
in
{
  programs.bash.shellAliases = myAliases;
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      custom = "/etc/nixos/system/zsh-themes";
      theme = "gruvbox";
      plugins = [ 
        
      ];
    };
    shellAliases = myAliases;
  };
  environment.systemPackages = with pkgs; [ tldr ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
}
