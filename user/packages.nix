{ config, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;
	
	home.packages = with pkgs; 
	[
	micro
	#jetbrains.idea-ultimate
	neofetch	
	#plover.dev
	#discord
	];
	#fix for application picker
	programs.bash.enable = true;
	targets.genericLinux.enable = true;
	xdg.mime.enable = true;
}
