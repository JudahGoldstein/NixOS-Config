{config, pkgs, ...}:
let	
    myAliases = {
        "ll" = "ls -la";
        ".." = "cd ..";
        "lg" = "lazygit";
        "nix-update" = "nh os boot --update && nh home switch --update && nh clean all --keep 3 && sudo nix-store --optimise -v"; #this is definitely not something to keep, but while getting an initial setup it's usefull
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
            plugins = [];
        };
    };
}
