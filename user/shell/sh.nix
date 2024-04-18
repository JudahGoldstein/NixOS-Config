{config, pkgs, ...}:
let	
	myAliases = {
		"ll" = "ls -la";
		".." = "cd ..";
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
		};
	};	
}
